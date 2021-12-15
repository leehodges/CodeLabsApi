FactoryBot.define do
  factory :user do
    email { "MyString" }
    first_name { "MyString" }
    last_name { "MyString" }
    password { "MyString" }
    invitation_accepted { false }
    invitation_token { "MyString" }
    invitation_expiration { "2021-11-22 12:47:06" }
  end
end
