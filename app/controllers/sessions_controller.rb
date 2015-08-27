
class SessionsController < ApplicationController
  before_filter :redirect_logged_in_users, only: [:new]

  # GET /login
  def new

  end

  # POST /session
  def create
    user = authenticate(session_params)

    if user.present?
      login(user)
      redirect_back_or storefront_path
    else
      flash.now[:credentials] = t('errors.login')
      render action: "new", status: :unauthorized
    end
  end

  # DELETE /session
  def destroy
    logout
    redirect_to storefront_url
  end

  private

  def redirect_logged_in_users
    if logged_in?
      redirect_to storefront_url
    end
  end

  def session_params
    params[:session] || {}
  end
end
