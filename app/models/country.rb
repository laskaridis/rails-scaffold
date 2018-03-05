class Country < ApplicationRecord

  validates :code,
    presence: true,
    uniqueness: true

  def name
    I18n.t "countries.#{code}"
  end
end
