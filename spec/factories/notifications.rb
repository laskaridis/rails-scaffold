FactoryBot.define do
  factory :notification do
    type    { "default" }
    subject { "Test notification" }
    body    { "This is a test notification" }
    read    { true }
    user
  end
end
