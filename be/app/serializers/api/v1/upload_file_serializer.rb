class Api::V1::UploadFileSerializer < ActiveModel::Serializer
  attributes :id, :origin_url, :thumbnail_url, :metadata
  belongs_to :resource, polymorphic: true

  def origin_url
    object.origin_url
  end

  def thumbnail_url
    object.thumbnail_url
  end
  
  def metadata
    object.metadata_to_json
  end
end
