require 'rails_helper'

RSpec.describe Launch, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:admin_id) }
  it { is_expected.to validate_presence_of(:date) }
end
