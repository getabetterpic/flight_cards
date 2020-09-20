require 'rails_helper'

RSpec.describe FlightCard, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_presence_of(:rocket_name) }
end
