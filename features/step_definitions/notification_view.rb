class NotifiactionsView
  include Capybara::DSL

  def initialize(notification)
    @notification = notification
  end

  def visible?
    within "#notifications" do
      find("#notification-#{@notification.id}")
    end
  end
end
