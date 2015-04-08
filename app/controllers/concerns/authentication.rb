module Authentication
  extend ActiveSupport::Concern

  included do
    helper_method :current_user, :logged_in?, :logged_out?
    hide_action(
      :authenticate,
      :current_user,
      :current_user=,
      :login,
      :logout,
      :logged_in?,
      :logged_out?
    )
  end

  def authenticate(params)
    User.authenticate(
      params[:email],
      params[:password])
  end

  def current_user
    User.find_by_id(session[:user_id])
  end

  def login(user)
    session[:user_id] = user.id
  end

  def logout
    session[:user_id] = nil
  end

  def logged_in?
    session[:user_id].present?
  end

  def logged_out?
    !logged_in?
  end
end
