FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  factory :user do
    email
    password 'password'

    trait :with_confirmed_email do
      email_confirmation_token        { SecureRandom.hex(20) }
      email_confirmation_requested_at { DateTime.now }
      email_confirmed_at              { DateTime.now }
    end

    trait :with_changed_password do
      password_change_token        { SecureRandom.hex(20) }
      password_change_requested_at { DateTime.now }
      password_changed_at          { DateTime.now }
    end

    trait :pending_password_change do
      password_change_token        { SecureRandom.hex(20) }
      password_change_requested_at { DateTime.now }
    end
  end
end
