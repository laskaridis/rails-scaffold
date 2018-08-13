class LocalizationSettingsController < ApplicationController
  
  # PUT /localization_settings
  def update
    save_localization_settings_to_cookies
    if user_signed_in?
      current_user.update_attributes!(localization_settings_from_params)
    end
    flash[:notice] = "Your localization settings have changed"
    redirect_back(fallback_location: root_path)
  end

  def save_localization_settings_to_cookies
    cookies[:country_id] = localization_settings_from_params[:country_id]
    cookies[:currency_id] = localization_settings_from_params[:currency_id]
    cookies[:language_id] = localization_settings_from_params[:language_id]
  end

  def localization_settings_from_params
    params.fetch(:localization_settings, {}).permit(:country_id, :currency_id, :language_id)
  end
end
