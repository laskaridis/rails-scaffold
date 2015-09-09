module Localization
  extend ActiveSupport::Concern

  included do
    before_action :set_locale
    hide_action(
      :default_url_options,
      :set_locale,
      :locale_from_url_parameters,
      :locale_from_client
    )
  end

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end

  def set_locale

    I18n.locale =
      locale_from_url_parameters ||
      locale_from_client ||
      I18n.default_locale
  end

  def locale_from_url_parameters
    params[:locale]
  end

  def locale_from_client
    if request.env["HTTP_ACCEPT_LANGUAGE"]
      request.env["HTTP_ACCEPT_LANGUAGE"].scan(/^[a-z]{2}/).first
    end
  end
end
