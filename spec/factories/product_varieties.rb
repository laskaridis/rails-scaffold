FactoryBot.define do
  factory :product_variety, aliases: [:fuji] do
    association :product_family, factory: :apple, strategy: :build
    name "Fuji"
  end
end
