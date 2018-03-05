FactoryBot.define do
  factory :product_family, aliases: [:apple] do
    association :product_category, factory: :fruits, strategy: :build
    name "Apple"
  end
end
