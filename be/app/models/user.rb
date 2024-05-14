class User < ApplicationRecord
  validates :email, presence: true,
                    length: {maximum: Settings.user.email_max},
                    format: {with: Settings.user.email_format},
                    uniqueness: true
  validates :name, presence: true,
                   length: {maximum: Settings.user.name_max}
end
