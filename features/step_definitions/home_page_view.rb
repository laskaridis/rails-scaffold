class HomePageView
  include Capybara::DSL

  def unread_notification_count
    find("span#notifications_badge").text
  end
end
