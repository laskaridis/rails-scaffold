class NotificationsController < ApplicationController

  # GET /notifications
  def index
    @notifications = Notification.where(user: current_user).all
  end
end
