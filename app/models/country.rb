class Country < ActiveRecord::Base

  validates :code,
    presence: true,
    uniqueness: true

  def name
    I18n.t "countries.#{code}"
  end
end
