class ProductVariety < ApplicationRecord
  belongs_to :product_family
  validates :product_family, presence: true
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
