Given("I receive notifications by email") do
  @user.update_attributes!(receive_email_notifications: true)
end

When("I visit by account preferences") do
  visit user_preferences_path
  expect(page).to have_content "Edit Preferences"
end

When("I opt out from receiving email notifications") do
  uncheck("user_receive_email_notifications")
  click_button "Update preferences"
end

Then("my preferences should be updated successfully") do
  expect(page).to have_content "Your profle has been updated"
end
