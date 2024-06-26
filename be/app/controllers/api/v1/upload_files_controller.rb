class Api::V1::UploadFilesController < ApplicationController
  before_action :check_logged_in!, only: [:presigned_url]
  def presigned_url
    file_name = params[:file_name]
    content_type = params[:content_type]

    raise_invalid_content_type unless Settings.aws_s3.allowed_file_types.include?(content_type)

    key = generate_uniq_key(file_name)
    presigned_url = S3Service.instance.presigned_url(key:, content_type:)
    RedisClientService.new.set_presigned_url_cache(
      presigned_url:,
      key:,
      file_name:,
      content_type:
    )
    render json: {
      success: true,
      data: {
        url: presigned_url,
        key:
      }
    }
  end

  private

  def generate_uniq_key(file_name)
    timestamp = Time.now.to_i
    random_string = SecureRandom.hex(8)
    "#{timestamp}_#{random_string}_#{file_name}"
  end

  def presigned_url_params
    params.permit(:file_name, :file_type)
  end

  def raise_invalid_content_type
    raise Errors::Api::BadRequest, FileErrorConstant::INVALID_CONTENT_TYPE
  end

end
