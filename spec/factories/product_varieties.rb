FactoryBot.define do
  factory :product_variety, aliases: [:fuji] do
    association :product_family
    name "Fuji"
  end
end
