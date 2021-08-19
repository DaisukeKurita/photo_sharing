class User < ApplicationRecord
  mount_uploader :profile_image, ImageUploader
  has_secure_password
  validates :profile_image, presence: true
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, length: { minimum: 6 }
  before_validation { email.downcase! }
end
