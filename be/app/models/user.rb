class User < ApplicationRecord
  # has_one :avatar, as: :resource, class_name: UploadFile.name, dependent: :destroy
  has_many :posts, dependent: :destroy
  # accepts_nested_attributes_for :avatar, allow_destroy: true

  validates :email, presence: true,
                    length: {maximum: Settings.user.email_max},
                    format: {with: Settings.user.email_format},
                    uniqueness: true
  validates :name, presence: true,
                   length: {maximum: Settings.user.name_max}
  has_secure_password
  validates :password, presence: true,
                       length: {minimum: Settings.user.password_min,
                                maximum: Settings.user.password_max}
  before_save :downcase_email

  def self.secure_password(length: 12)
    SecureRandom.alphanumeric(length)
  end

  private

  def downcase_email
    email.downcase!
  end

end
