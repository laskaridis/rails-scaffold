class Organization < ApplicationRecord
  belongs_to :address
  belongs_to :user, inverse_of: :organization
  validates :name, presence: true
  validates :address, presence: true
  validates :vat_number, presence: true
  validates :tax_office, presence: true
  validates :contact_first_name, presence: true
  validates :contact_last_name, presence: true
  validates :contact_email, presence: true
  accepts_nested_attributes_for :address
end
