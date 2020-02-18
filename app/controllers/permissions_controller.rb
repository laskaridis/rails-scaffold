class PermissionsController < ApplicationController
  before_action :authenticate_user!

  # GET /roles/:role_id/permissions
  def index
    @role = Role.find(params[:role_id])
  end

end
