class UploadFile < ApplicationRecord
  belongs_to :resource, polymorphic: true
  validates :file_name, presence: true
  validates :content_type, presence: true
  validates :key, presence: true
end
