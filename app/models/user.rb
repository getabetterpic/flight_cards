class User < ApplicationRecord
  has_secure_password
  validates :username, :password_digest, :role, presence: true
  validates :role, inclusion: %w[flier rso lco launch_admin]
end
