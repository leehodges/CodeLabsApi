require 'faker'
FactoryBot.define do
  factory :medication do
    name { Faker::Alphanumeric.alpha(number: 10) }
    dosage { Faker::Alphanumeric.alpha(number: 10) }
    frequency { ['daily', 'weekly', 'monthly', ''].sample }
    date { rand 1..31 }
    day { ['sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday'].sample }
    benefits { Faker::Lorem.paragraph }
    side_effects { Faker::Lorem.paragraph }
    start_date { Faker::Alphanumeric.alpha(number: 10) }
    stop_date { Faker::Alphanumeric.alpha(number: 10) }
    reason_stopped { Faker::Lorem.sentence }
    is_current { Faker::Boolean.boolean }
    morning { Faker::Boolean.boolean }
    midday { Faker::Boolean.boolean }
    evening { Faker::Boolean.boolean }
    night { Faker::Boolean.boolean }
  end
end