class User < ApplicationRecord
  mount_uploader :profile_image, ImageUploader
  has_secure_password
end
