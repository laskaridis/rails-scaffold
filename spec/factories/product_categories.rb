FactoryBot.define do
  factory :product_category, aliases: [:fruits] do 
    name "Fruits"

    factory :vegetables do
      name "Vegetables"
    end

    factory :nuts do
      name "Nuts"
    end
  end
end
