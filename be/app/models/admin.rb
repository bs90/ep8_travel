class Admin < ApplicationRecord
  has_secure_password
  validates :email, presence: true,
                    length: {maximum: Settings.user.email_max},
                    format: {with: Settings.user.email_format},
                    uniqueness: true
  validates :name, presence: true,
                   length: {maximum: Settings.user.name_max}
  validates :password, presence: true,
                       length: {minimum: Settings.user.password_min,
                                maximum: Settings.user.password_max}

  before_save :downcase_email

  private

  def downcase_email
    email.downcase!
  end
end
