class Launch < ApplicationRecord
  validates :name, :admin_id, :date, presence: true
  belongs_to :admin, class_name: 'User'
end
