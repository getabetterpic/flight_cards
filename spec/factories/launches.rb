FactoryBot.define do
  factory :launch do
    name { 'Creekside Farms' }
    date { '2020-05-12 16:41:37' }
    location { 'Creekside Farms' }
    admin { FactoryBot.create(:user, :launch_admin) }
  end
end
