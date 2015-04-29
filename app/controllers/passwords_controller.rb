class PasswordsController < ApplicationController

  # GET /passwords/new
  def new

  end

  # POST /passwords
  def create
    if user = find_user_for_create
      user.forgot_password
      flash[:success] = pending_confirmation_message
      redirect_to storefront_url
    else
      flash[:email_not_found] = email_not_found_message
      render action: "new"
    end
  end

  # GET /passwords/:id/edit?token=token
  def edit
    @user = find_user_for_edit

    if @user.present?
      if @user.password_change_expired?
        flash[:warning] = token_expired_message
        render action: "new"
      end
    else
      redirect_to storefront_url
    end
  end

  # PUT /passwords/:id?token=token
  def update
    @user = find_user_for_update

    if @user.present?
      if @user.change_password password_params[:password]
        login @user
        flash[:success] = password_changed_message
        redirect_to storefront_url
      else
        render template: "passwords/edit"
      end
    else
      redirect_to storefront_url
    end
  end

  private

  def pending_confirmation_message
    I18n.t("successes.reset_email").gsub(/:email/, normalized_email_from_params)
  end

  def email_not_found_message
    I18n.t("errors.reset_email_not_found")
  end

  def token_expired_message
    I18n.t("warning.password_change_expired")
  end

  def password_changed_message
    I18n.t("successes.password_changed")
  end

  def find_user_for_create
    User.find_by_email normalized_email_from_params
  end

  def find_user_for_edit
    User.find_by_id_and_password_change_token params[:id], params[:token]
  end

  def find_user_for_update
    User.find_by_id_and_password_change_token params[:id], params[:token]
  end

  def password_params
    params[:password] || {}
  end

  def normalized_email_from_params
    User.normalize_email password_params[:email]
  end
end
