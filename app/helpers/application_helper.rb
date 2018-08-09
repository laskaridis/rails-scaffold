module ApplicationHelper

  def country_select_options(selected_country_id)
    options_from_collection_for_select(cached_countries, :id, :name, selected_country_id)
  end

  def language_select_options(selected_language_id)
    options_from_collection_for_select(cached_languages, :id, :name, selected_language_id)
  end

  def currency_select_options(selected_currency_id)
    options_from_collection_for_select(cached_currencies, :id, :name, selected_currency_id)
  end

  private

  def cached_countries
    Rails.cache.fetch("countries/all", expires_in: 12.hours) do
      Country.all.sort
    end
  end

  def cached_languages
    Rails.cache.fetch("languages/all", expires_in: 12.hours) do
      Language.all
    end
  end

  def cached_currencies
    Rails.cache.fetch("currencies/all", expires_in: 12.hours) do
      Currency.all.sort
    end
  end
end
