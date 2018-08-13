class Currency < ApplicationRecord
  validates :code, presence: true, uniqueness: { case_sensitive: false }
  validates :symbol, presence: true 

  def self.default
    find_by!(code: "EUR")
  end

  def name
    "#{I18n.t("currencies.#{code.downcase}")} (#{symbol})"
  end
end
