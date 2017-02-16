FactoryGirl.define do

  factory :message do
    association :sender, factory: :user
    association :recipient, factory: :user
    subject "Subject"
    message "Message content"
  end
end
