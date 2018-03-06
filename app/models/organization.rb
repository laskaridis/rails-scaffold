class Organization < ApplicationRecord
  belongs_to :address
  belongs_to :contact
  belongs_to :user, inverse_of: :organization
  validates :name, presence: true
  validates :address, presence: true
  validates :contact, presence: true
  validates :vat_number, presence: true
  validates :tax_office, presence: true
  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :contact
end
