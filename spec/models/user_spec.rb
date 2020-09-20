require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:role) }
  it { is_expected.to validate_inclusion_of(:role).in_array(%w[flier rso lco launch_admin]) }

  describe '#launch_admin?' do
    let(:launch_admin) { FactoryBot.build(:user, :launch_admin) }
    let(:flier) { FactoryBot.build(:user) }

    it 'returns true if role is launch_admin' do
      expect(launch_admin.launch_admin?).to eq true
    end

    it 'returns false if role is anything else' do
      expect(flier.launch_admin?).to eq false
    end
  end
end
