FactoryBot.define do
  factory :product_family, aliases: [:apple] do
    association :product_category
    name { "Apple" }
  end
end
