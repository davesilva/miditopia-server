class User < ActiveRecord::Base
  has_secure_password

  has_many :uploads

  validates :password, length: { minimum: 6 },
                       confirmation: true,
                       allow_blank: true
  validates :password_confirmation, presence: true,
                                    if: -> { password.present? }
  validates :email, presence: true,
                    uniqueness: true,
                    format: { with: /\A.*@.*\..*\z/ }
  validates :username, presence: true

  before_save { email.downcase! }
end
