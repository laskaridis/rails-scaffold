class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_user

  # GET /user/profile
  def profile
  end

  # PUT /user/profile
  def update_profile
    @user.update_attributes(user_profile_params)
    if @user.save
      flash[:notice] = I18n.t('successes.profile_updated')
      redirect_to user_profile_path
    else
      render :profile
    end
  end

  # GET /user/settings
  def settings
  end

  # PUT /user/settings
  def update_settings
    @user.update_attributes(user_settings_params)
    if @user.save
      flash[:notice] = I18n.t('successes.profile_updated')
      redirect_to user_settings_path
    else
      render :settings
    end
  end

  # GET /user/preferences
  def preferences
  end

  # PUT /user/preferences
  def update_preferences
    @user.update_attributes(user_preferences_params)
    if @user.save
      flash[:notice] = I18n.t('successes.profile_updated')
      redirect_to user_preferences_path
    else
      render :preferences
    end
  end

  # GET /user/security
  def security
  end
  #
  # PUT /user/change_password
  def change_password
    if @user.update_with_password(user_password_params)
      @user.send_password_change_notification
      bypass_sign_in(@user)
      flash[:notice] = I18n.t("successes.password_changed")
      redirect_to user_security_path
    else
      render :security
    end
  end

  # DELETE /user
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

  def change_password_params
    params.fetch(:change_password_form, {}).permit(
      :old_password,
      :password,
      :password_confirmation
    )
  end

  def delete_account_params
    params.fetch(:delete_account_form, {}).permit(:email)
  end

  private

  def user_profile_params
    params.fetch(:user, {}).permit(:gender, :birth_date)
  end

  def user_settings_params
    params.fetch(:user, {}).permit(
      :country_id,
      :currency_id,
      :language_id,
      :time_zone
    )
  end

  def user_preferences_params
    params.fetch(:user, {}).permit(:receive_email_notifications)
  end

  def redirect_logged_in_users
    if logged_in?
      redirect_to root_url
    end
  end

  def user_password_params
    params.fetch(:user, {}).permit(:current_password, :password, :password_confirmation)
  end
end
