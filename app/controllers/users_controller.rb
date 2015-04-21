class UsersController < ApplicationController
  before_filter :redirect_logged_in_users, only: [:create, :new]

  # GET /login
  def new
    @user = user_from_params
  end

  # POST /users
  def create
    @user = user_from_params

    if @user.save
      login(@user)
      redirect_to storefront_path
    else
      render "new"
    end
  end

  def edit

  end

  def show

  end

  def update

  end

  def destroy

  end

  # GET /verify/:token
  def verify
    user = find_user_by_email_confirmation_token
    if user.present?
      unless user.confirm_email
        user.reset_email_confirmation_token
        flash[:warning] = I18n.t('errors.verify_email.expired')
      end
    end

    redirect_to storefront_url
  end

  private

  def find_user_by_email_confirmation_token
    User.find_by_email_confirmation_token params[:token]
  end

  def redirect_logged_in_users
    if logged_in?
      redirect_to storefront_url
    end
  end

  def user_from_params
    User.new(user_params)
  end

  def user_params
    params.fetch(:user, {}).permit(:email, :password)
  end
end
