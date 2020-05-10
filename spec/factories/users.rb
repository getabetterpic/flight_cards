FactoryBot.define do
  factory :user do
    username { 'thisuser' }
    password { 'somepassword' }
    password_confirmation { 'somepassword' }
    role { 'flier' }
  end
end
