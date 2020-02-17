module Admin
  class UsersController < ApplicationController
    before_action :authenticate_user!

    # GET /users
    def index
      @users = User.all
    end

  end
end
