module Localization
  extend ActiveSupport::Concern

  included do
    before_action :set_locale
    hide_action(
      :default_url_options,
      :set_locale
    )
  end

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
