class Currency < ActiveRecord::Base

  validates :code,
    presence: true,
    uniqueness: { case_sensitive: false }
  validates :symbol,
    presence: true

  def name
    I18n.t("currencies.#{code.downcase}")
  end
end
