class FlightCard < ApplicationRecord
  validates :name, :user_id, :rocket_name, presence: true

  belongs_to :user
  belongs_to :launch

  scope :not_flown, -> { where.not(flown: true) }
  scope :flown, -> { where(flown: true) }
  scope :not_rso_approved, -> { where.not(rso_approved: true) }
  scope :waiting_for_rso, -> { not_flown.not_rso_approved }
  scope :rso_approved, -> { where(rso_approved: true) }
  scope :waiting_for_lco, -> { not_flown.rso_approved }
  scope :for_launch, ->(launch_id) { where(launch_id: launch_id) }
end
