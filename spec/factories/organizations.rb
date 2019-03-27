FactoryBot.define do
  factory :organization do
    name { "OrganizationName" }
    vat_number { "1234567890" }
    tax_office { "TaxOffice" }
    association :address
    association :user
    association :contact
  end
end
