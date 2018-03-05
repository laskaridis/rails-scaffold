class ProductFamily < ApplicationRecord
  belongs_to :product_category
  has_many :product_varieties, inverse_of: :product_family
  validates :product_category, presence: true
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
