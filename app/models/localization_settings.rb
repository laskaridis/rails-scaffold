class LocalizationSettings
  include ActiveModel::Model

  attr_accessor :country
  attr_accessor :currency
  attr_accessor :language

  def initialize(opts = {})
    self.country = opts[:country]
    self.currency = opts[:currency] || Currency.default
    self.language = opts[:language] || Language.default
  end

  def country_id
    self.country&.id
  end

  def currency_id
    self.currency&.id
  end

  def language_id
    self.language&.id
  end
end
