class Organization < ApplicationRecord
  belongs_to :address
  validates :name, presence: true
  validates :address, presence: true
  validates :vat_number, presence: true
  validates :contact_first_name, presence: true
  validates :contact_last_name, presence: true
  validates :contact_email, presence: true
end
