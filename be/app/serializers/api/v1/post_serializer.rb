class Api::V1::PostSerializer < ActiveModel::Serializer
  attributes :id, :caption, :created_at
  has_many :upload_files
  belongs_to :user
end
