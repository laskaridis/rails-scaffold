class ProductFamily < ApplicationRecord
  belongs_to :product_category
  validates :product_category, presence: true
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
