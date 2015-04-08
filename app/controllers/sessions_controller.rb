
class SessionsController < ApplicationController

  # GET /login
  def new

  end

  # POST /session
  def create
    user = authenticate(session_params)

    if user.present?
      login(user)
      redirect_to storefront_path
    else
      flash.now[:error] = t('errors.login')
      render action: "new", status: :unauthorized
    end
  end

  # DELETE /session
  def destroy
    logout
    redirect_to storefront_path
  end

  private

  def session_params
    params[:session] || {}
  end
end
