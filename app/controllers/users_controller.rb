class UsersController < ApplicationController

  def new
    @user = user_from_params
  end

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

  private

  def user_from_params
    User.new(user_params)
  end

  def user_params
    params.fetch(:user, {}).permit(:email, :password)
  end
end
