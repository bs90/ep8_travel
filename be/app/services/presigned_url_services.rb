class PresignedUrlService
  def initialize(bucket, key, exp: 3600)
    @bucket = bucket
    @key = key
    @expires_in = expires_in
    @s3 = Aws::S3::Resource.new
  end

  def generate_presigned_url
    obj = @s3.bucket(@bucket).object(@key)
    obj.presigned_url(:put, expires_in: @expires_in)
  end
end