require 'faker'
FactoryBot.define do
  factory :user do
    id { Faker::Number.unique.number(digits: 5) }
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    phone { Faker::Number.number(digits: 10) }
    password { Faker::Internet.password(min_length: 8) }
    invitation_accepted { false }
    invitation_token { Faker::Blockchain::Bitcoin.address }
    invitation_expiration { DateTime.now + 7.days }
  end
end
