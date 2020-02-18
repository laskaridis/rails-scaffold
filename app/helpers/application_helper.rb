module ApplicationHelper

  def display_error_class_for(model, property)
    unless model.errors[property].empty?
      'has-error'
    end
  end

  def display_error_for(model, property)
    if model.errors[property].any?
      tag.span class: "help-block" do
        model.errors.full_messages_for(property).first
      end
    end
  end

  def unread_notifications_count
    Notification.unread.count
  end

  def user_has_unread_notifications?
    unread_notifications_count > 0
  end

  def selected_localization_settings
    @localization_settings ||= LocalizationSettings.new(
      country: cached_country(cookies[:country_id]),
      currency: cached_currency(cookies[:currency_id]),
      language: cached_language(cookies[:language_id])
    )
  end

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

  def cached_country(country_id)
    Rails.cache.fetch("countries/#{country_id}", expires_in: 12.hours) do
      Country.find_by(id: country_id)
    end
  end

  def cached_countries
    Rails.cache.fetch("countries/all", expires_in: 12.hours) do
      Country.all.sort
    end
  end

  def cached_language(language_id)
    Rails.cache.fetch("languages/#{language_id}", expires_in: 12.hours) do
      Language.find_by(id: language_id)
    end
  end

  def cached_languages
    Rails.cache.fetch("languages/all", expires_in: 12.hours) do
      Language.all
    end
  end

  def cached_currency(currency_id)
    Rails.cache.fetch("currencies/#{currency_id}", expires_in: 12.hours) do
      Currency.find_by(id: currency_id)
    end
  end

  def cached_currencies
    Rails.cache.fetch("currencies/all", expires_in: 12.hours) do
      Currency.all.sort
    end
  end
end
