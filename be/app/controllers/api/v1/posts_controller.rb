class Api::V1::PostsController < ApplicationController
  before_action :check_logged_in!, only: [:create]

  def index
    pagy_info, posts = pagy_posts Post.includes(:upload_files).all.newest
    render json: {
      sucess: true,
      data: {
        posts:,
        pagy_info:,
      }
    }
  end

  def show
    post = Post.find(params[:id])
    photo_url = S3Service.instance.get_file_url(key: post.upload_files[0][:key])
    render json: {
      success: true,
      data: {
        caption: post.caption,
        photo_url:
      }
    }
  end

  def create
    post_photo = prepare_create_file(
      presigned_url: post_params[:presigned_url],
      key: post_params[:caption]
    )
    ActiveRecord::Base.transaction do
      @post = current_user.posts.create!(caption: post_params[:caption])
      @post.upload_files.create!(
        file_name: post_photo[:file_name],
        key: post_photo[:key],
        content_type: post_photo[:file_name],
        metadata: post_params[:metadata].to_json
      )
    end
    render json: {
      sucess: true,
      data: @post
    }, status: :created
  end

  private

  def post_params
    params.permit(:caption, :presigned_url, :image_key,
                  metadata: [:long, :lat, :location, :shooting_date])
  end

  def prepare_create_file(presigned_url:, key:)
    redis_file_info = RedisClientService.new.get_presigned_url_cache(
      presigned_url:,
      key:
    )
    raise_file_error if redis_file_info.blank?
    redis_file_info
  end


  def raise_file_error
    raise Errors::Api::BadRequest.new(
      code: I18n.t('errors.codes.file_empty'),
      message: I18n.t('errors.messages.file_empty')
    )
  end
end
