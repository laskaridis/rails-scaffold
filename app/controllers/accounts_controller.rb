class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_user

  # GET /account/profile
  def profile
  end

  # PUT /account/profile
  def update_profile
    @user.update_attributes(account_profile_params)
    if @user.save
      flash[:notice] = I18n.t('successes.profile_updated')
      redirect_to account_profile_path
    else
      render :profile
    end
  end

  # GET /account/settings
  def settings
  end

  # PUT /account/settings
  def update_settings
    @user.update_attributes(account_settings_params)
    if @user.save
      flash[:notice] = I18n.t('successes.profile_updated')
      redirect_to account_settings_path
    else
      render :settings
    end
  end

  # GET /account/preferences
  def preferences
  end

  # PUT /account/preferences
  def update_preferences
    @user.update_attributes(account_preferences_params)
    if @user.save
      flash[:notice] = I18n.t('successes.profile_updated')
      redirect_to account_preferences_path
    else
      render :preferences
    end
  end

  # GET /account/security
  def security
  end
  #
  # PUT /account/change_password
  def change_password
    if @user.update_with_password(account_password_params)
      @user.send_password_change_notification
      bypass_sign_in(@user)
      flash[:notice] = I18n.t("successes.password_changed")
      redirect_to account_security_path
    else
      render :security
    end
  end

  # DELETE /account
  def destroy
    @delete_account_form = DeleteAccountForm.new(current_user)

    if @delete_account_form.perform(delete_account_params)
      flash[:success] = "Your account has been deleted"
      logout
      redirect_to root_path
    else
      render :security
    end
  end

  private

  def set_current_user
    @user = current_user
  end

  def delete_account_params
    params.fetch(:delete_account_form, {}).permit(:email)
  end

  private

  def account_profile_params
    params.fetch(:user, {}).permit(:gender, :birth_date)
  end

  def account_settings_params
    params.fetch(:user, {}).permit(
      :country_id,
      :currency_id,
      :language_id,
      :time_zone
    )
  end

  def account_preferences_params
    params.fetch(:user, {}).permit(:receive_email_notifications)
  end

  def account_password_params
    params.fetch(:user, {}).permit(:current_password, :password, :password_confirmation)
  end
end
