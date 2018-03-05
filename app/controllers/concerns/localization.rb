module Localization
  extend ActiveSupport::Concern

  included do
    before_action :set_locale
  end

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end

  def set_locale
    I18n.locale = url_parameters[:locale] || locale_from_client || I18n.default_locale
  end

  def url_parameters
    params.permit([:locale]).to_h
  end

  def locale_from_client
    if request.env["HTTP_ACCEPT_LANGUAGE"]
      request.env["HTTP_ACCEPT_LANGUAGE"].scan(/^[a-z]{2}/).first
    end
  end
end
