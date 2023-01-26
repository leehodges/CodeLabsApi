require 'faker'
FactoryBot.define do
  factory :token do
    id { Faker::Number.unique.number(digits: 5) }
    user_id { nil }
    value { Faker::Blockchain::Bitcoin.address }
    expiry { DateTime.now + 7.days }
    ip { nil }
    revocation_date { nil }
  end
end
