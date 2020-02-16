class Permission < ApplicationRecord
  validates :name,
    presence: true,
    length: { maximum: 255 },
    uniqueness: { case_sensitive: false }
  validates :action,
    presence: true,
    length: { maximum: 255 },
    uniqueness: { scope: :resource, case_sensitive: false }
  validates :resource,
    presence: true,
    length: { maximum: 255 }
end
