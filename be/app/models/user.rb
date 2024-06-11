class User < ApplicationRecord
  # has_one :avatar, as: :resource, class_name: UploadFile.name, dependent: :destroy
  has_many :posts
  # accepts_nested_attributes_for :avatar, allow_destroy: true

  validates :email, presence: true,
                    length: {maximum: Settings.user.email_max},
                    format: {with: Settings.user.email_format},
                    uniqueness: true
  validates :name, presence: true,
                   length: {maximum: Settings.user.name_max}
end
