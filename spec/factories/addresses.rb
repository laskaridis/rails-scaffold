FactoryBot.define do
  factory :address do
    street "Infinite Loop 1"
    city "Cupertino"
    region "California"
    postal_code "95014"
    country :united_states
  end
end