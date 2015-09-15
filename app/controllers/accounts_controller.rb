class AccountsController < ApplicationController
  before_filter :require_login

  # GET /accounts
  def edit
    @account = ChangePasswordForm.new current_user
  end

  # PUT /accounts/change_password
  def change_password
    @account = ChangePasswordForm.new current_user
    if @account.perform change_password_params
      flash[:success] = I18n.t("successes.password_changed")
      redirect_to edit_account_path
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
end
