FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  factory :user do
    email
    password 'password'

    trait :with_confirmed_email do
      email_confirmation_token        { Token.new }
      email_confirmation_requested_at { DateTime.now }
      email_confirmed_at              { DateTime.now }
    end

    trait :with_changed_password do
      password_change_token        { Token.new }
      password_change_requested_at { DateTime.now }
      password_changed_at          { DateTime.now }
    end

    trait :pending_password_change do
      password_change_token        { Token.new }
      password_change_requested_at { DateTime.now }
    end

    trait :with_expired_password_change_token do
      password_change_token { Token.new }
      password_change_requested_at do
        config = Configuration.configuration
        expiration_period = config.password_change_expiration
        (expiration_period + 1).hours.ago
      end
    end
  end
end
