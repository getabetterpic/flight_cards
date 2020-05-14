FactoryBot.define do
  factory :launch do
    date { '2020-05-12 16:41:37' }
    location { 'Creekside Farms' }
    admin { FactoryBot.create(:user, role: :launch_admin) }
  end
end
