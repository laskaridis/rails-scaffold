module Authentication
  extend ActiveSupport::Concern

  included do
    helper_method :current_user, :logged_in?, :logged_out?
  end

  def current_user
    User.find_by_id(session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def logged_out?
    !logged_in?
  end

  def authenticate(params)
    User.authenticate(params[:email], params[:password])
  end

  def login(user)
    session[:user_id] = user.id
  end

  def logout
    session[:user_id] = nil
  end
end
