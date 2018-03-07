
class SessionsController < ApplicationController
  before_action :redirect_logged_in_users, only: [:new]

  # GET /login
  def new

  end

  # POST /session
  def create
    user = authenticate(session_params)

    if user.present?
      if user.email_confirmed?
        login user
        if user.organization.nil?
          redirect_to company_signup_welcome_path
        else
          redirect_back_or root_url
        end
      else
        flash.now[:error] = pending_email_verification_message
        render action: "new", status: :unauthorized
      end
    else
      flash.now[:error] = invalid_credentials_message
      render action: "new", status: :unauthorized
    end
  end

  # DELETE /session
  def destroy
    logout
    redirect_to root_url
  end

  private

  def invalid_credentials_message
    I18n.t('errors.login')
  end

  def pending_email_verification_message
    I18n.t('errors.verify_email.pending')
  end

  def redirect_logged_in_users
    if logged_in?
      redirect_to root_url
    end
  end

  def session_params
    params.require(:session).permit([:email, :password]).to_h
  end
end
