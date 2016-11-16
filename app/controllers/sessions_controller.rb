
class SessionsController < ApplicationController
  before_filter :redirect_logged_in_users, only: [:new]

  # GET /login
  def new

  end

  # POST /session
  def create
    user = authenticate(session_params)

    if user.present?
      if user.email_confirmed?
        login user
        redirect_back_or root_url
      else
        flash[:error] = pending_email_verification_message
        redirect_to login_url
      end
    else
      flash.now[:error] = t('errors.login')
      render action: "new", status: :unauthorized
    end
  end

  # DELETE /session
  def destroy
    logout
    redirect_to root_url
  end

  private

  def pending_email_verification_message
    I18n.t('errors.verify_email.pending')
  end

  def redirect_logged_in_users
    if logged_in?
      redirect_to root_url
    end
  end

  def session_params
    params[:session] || {}
  end
end
