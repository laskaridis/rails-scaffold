FactoryBot.define do
  factory :organization do
    name "OrganizationName"
    vat_number "1234567890"
    tax_office "TaxOffice"
    contact_first_name "ContactFirstName"
    contact_last_name "ContactLastName"
    contact_email "contact@localhost.com"
    association :address
    association :user
  end
end
