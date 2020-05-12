FactoryBot.define do
  factory :flight_card do
    name { 'Felton' }
    memberships { {} }
    rocket_manufacturer { 'Estes' }
    rocket_name { 'Flip-Flyer' }
    rocket_type { 'Kit' }
    stages { 1 }
    cluster { 1 }
    launch_guide { '1/8 in' }
    motor_manufacturer { 'Estes' }
    motor { 'C6-5' }
    recovery { { parachute: 'true' } }
    chute_release { '' }
    flight_info { {} }
  end
end
