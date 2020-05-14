class Launch < ApplicationRecord
  validates :name, :admin_id, :date, presence: true
  belongs_to :admin, class_name: 'User'
  has_secure_password :rso, validations: false
  has_secure_password :lco, validations: false
end
