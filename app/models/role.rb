class Role < ApplicationRecord
  has_and_belongs_to_many :permissions
  accepts_nested_attributes_for :permissions, allow_destroy: true
  validates :name,
    presence: true,
    length: { maximum: 255 },
    uniqueness: { case_sensitive: false }
end
