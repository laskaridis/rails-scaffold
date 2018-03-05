class Address < ApplicationRecord
  belongs_to :country
  validates :street, presence: true
  validates :city, presence: true
  validates :region, presence: true
  validates :postal_code, presence: true
  validates :country, presence: true
end
