FactoryBot.define do
  factory :user do
    sequence(:email) { |i| "some#{i}@email.com" }
    password { 'somepassword' }
    password_confirmation { 'somepassword' }
    role { 'flier' }

    trait :launch_admin do
      role { 'launch_admin' }
    end
  end
end
