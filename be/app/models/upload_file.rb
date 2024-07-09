class UploadFile < ApplicationRecord
  belongs_to :resource, polymorphic: true
  validates :file_name, presence: true
  validates :content_type, presence: true
  validates :key, presence: true

  def origin_url
    S3Service.instance.get_file_url(key: key)
  end

  def thumbnail_url
    thumb_bucket = ENV.fetch('S3_RESIZED_BUCKET_NAME', nil)
    thumb_key = FileConstant::THUMBNAILS + key
    S3Service.instance.get_file_url(key: thumb_key, bucket: thumb_bucket)
  end

  def metadata_to_json
    JSON.parse(metadata)
  end
end
