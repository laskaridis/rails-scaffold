class AccountsController < ApplicationController
  before_action :require_login

  # GET /accounts
  def edit
  end

  # PUT /accounts/change_password
  def change_password
    @change_password_form = ChangePasswordForm.new current_user
    if @change_password_form.perform change_password_params
      flash[:success] = I18n.t("successes.password_changed")
      redirect_to user_account_path
    else
      render :edit
    end
  end

  # DELETE /accounts
  def destroy
    @delete_account_form = DeleteAccountForm.new(current_user)

    if @delete_account_form.perform(delete_account_params)
      flash[:success] = "Your account has been deleted"
      logout
      redirect_to root_path
    else
      render :edit
    end
  end

  private

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
end
