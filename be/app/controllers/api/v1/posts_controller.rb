class Api::V1::PostsController < ApplicationController
  before_action :check_logged_in!, only: [:create]

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
      key: post_params[:image_key]
    )
    ActiveRecord::Base.transaction do
      @post = current_user.posts.create!(caption: post_params[:caption])
      @post.upload_files.create!(
        file_name: post_photo[:file_name],
        key: post_photo[:key],
        content_type: post_photo[:file_name]
      )
    end
    render json: {
      sucess: true,
      data: @post
    }
  end

  private

  def post_params
    params.permit(:caption, :presigned_url, :image_key)
  end

  def prepare_create_file(presigned_url:, key:)
    RedisClientService.new.get_presigned_url_cache(
      presigned_url:,
      key:
    )
    raise_file_error if redis_file_info.blank?
  end


  def raise_file_error
    raise Errors::Api::Unauthenticated.new(
      code: I18n.t('file error'),
      message: I18n.t('file is empty')
    )
  end
end
