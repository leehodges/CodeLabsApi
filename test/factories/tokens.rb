FactoryBot.define do
  factory :token do
    user { nil }
    value { "MyString" }
    expiry { "2021-11-22 12:52:50" }
    ip { "MyString" }
    revocation_date { "2021-11-22 12:52:50" }
  end
end
