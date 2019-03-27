FactoryBot.define do
  factory :contact do
    first_name { "FirstName" }
    last_name { "LastName" }
    email { "test@localhost.com" }
  end
end
