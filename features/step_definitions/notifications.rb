Given("I am a user having three unread notifications") do
  @user = create(:user, :with_confirmed_email, password: "password")
  create(:notification, user: @user, read: false)
  create(:notification, user: @user, read: false)
  create(:notification, user: @user, read: false)
end

Then("I should see a badge warning me about three unread notifications") do
  @view = HomePageView.new
  expect(@view.unread_notification_count).to eq "3"
end

Given("I am a user with three notifications") do
  @user = create(:user, :with_confirmed_email, password: "password")
  @n1 = create(:notification, subject: "Notification 1", user: @user, read: true)
  @n2 = create(:notification, subject: "Notification 2", user: @user, read: false)
  @n3 = create(:notification, subject: "Notification 3", user: @user, read: false)
end

When("list my notifications") do
  visit notifications_path
end

Then("I should see my three notifications") do
  notification = NotifiactionsView.new(@n1)
  expect(notification).to be_visible
  notification = NotifiactionsView.new(@n2)
  expect(notification).to be_visible
  notification = NotifiactionsView.new(@n3)
  expect(notification).to be_visible
end
