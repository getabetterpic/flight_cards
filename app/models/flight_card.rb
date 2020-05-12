class FlightCard < ApplicationRecord
  validates :name, :user_id, :rocket_name, presence: true

  belongs_to :user

  scope :not_flown, -> { where.not(flown: true) }
end
