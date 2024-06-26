class S3Service
  include Singleton
  def initialize
    @bucket = ENV.fetch('S3_BUCKET_NAME', 'ep8-travel-blog')
  end

  def presigned_url(key:, content_type:, expires_in: Settings.aws_s3.url_expires_in.to_i)
    signer = Aws::S3::Presigner.new
    signer.presigned_url(
      :put_object,
      bucket: @bucket,
      key:,
      content_type:,
      acl: 'private',
      expires_in:
    )
  end

  def get_file_url(key:)
    signer = Aws::S3::Presigner.new(client: @s3_client)
    signer.presigned_url(
      :get_object,
      bucket: @bucket,
      key:
    )
  end
end
