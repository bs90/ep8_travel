class Post < ApplicationRecord
  belongs_to :user
  has_many :upload_files, as: :resource, class_name: UploadFile.name, dependent: :destroy
  accepts_nested_attributes_for :upload_files, allow_destroy: true

  validates :caption, presence: true
end
