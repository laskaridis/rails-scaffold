class UsersController < ApplicationController
  before_filter :redirect_logged_in_users, only: [:create, :new]
  before_action :require_login, only: [:edit, :update]

  # GET /login
  def new
    @user = user_from_params_for_create
  end

  # POST /users
  def create
    @user = user_from_params_for_create

    if @user.save
      flash[:success] = user_registered_message
      redirect_to login_url
    else
      render "new"
    end
  end

  # GET /users/edit
  def edit
    @user = current_user
  end

  def show

  end

  # PUT /users
  def update
    @user = current_user

    @user.update_attributes user_params_for_update
    if @user.save
      flash[:success] = I18n.t('successes.profile_updated')
      redirect_to edit_user_path
    else
      render "edit"
    end
  end

  def destroy

  end

  # GET /verify/:token
  def verify
    user = find_user_by_email_confirmation_token

    if user.confirm_email
      flash[:success] = verify_email_success_message
    else
      user.reset_email_confirmation_token
      flash[:warning] = verify_email_expired_message
    end

    redirect_to login_url
  end

  private

  def user_registered_message
    I18n.t('successes.user_registered')
  end

  def verify_email_success_message
    I18n.t('successes.verify_email')
  end

  def verify_email_expired_message
    I18n.t('errors.verify_email.expired')
  end

  def find_user_by_email_confirmation_token
    User.find_by_email_confirmation_token! params[:token]
  end

  def redirect_logged_in_users
    if logged_in?
      redirect_to root_url
    end
  end

  def user_from_params_for_create
    User.new(user_params_for_create)
  end

  def user_params_for_update
    params.fetch(:user, {}).permit(
      :full_name,
      :gender,
      :country_id,
      :currency_id,
      :language_id,
      :time_zone,
      :birth_date,
      :receive_email_notifications
    )
  end

  def user_params_for_create
    params.fetch(:user, {}).permit(
      :full_name,
      :email,
      :password,
      :receive_email_notifications
    )
  end
end
