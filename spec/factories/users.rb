FactoryBot.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  factory :user do
    email
    password { 'password' }

    trait :with_confirmed_email do
      confirmation_token   { Token.new }
      confirmation_sent_at { DateTime.now }
      confirmed_at         { DateTime.now }
    end

    trait :with_unconfirmed_email do
      confirmation_token   { Token.new }
      confirmation_sent_at { DateTime.now }
      confirmed_at         { nil }
    end

    trait :with_company do
      association :organization
    end

    trait :with_no_company do
    end
  end
end
