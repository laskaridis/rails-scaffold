When("I visit my account security") do
  clear_emails
  visit user_security_path
  expect(page).to have_content "Change Password"
end

When("I enter a new password") do
  fill_in "user_current_password", with: @user.password
  fill_in "user_password", with: "mynewpassword"
  fill_in "user_password_confirmation", with: "mynewpassword"
  click_button "Change Password"
end

Then("my password should change successfully") do
  expect(page).to have_content "Your password has been successfully changed"
  click_link "Logout"
  click_link "Login"
  fill_in "user_email", with: @user.email
  fill_in "user_password", with: "mynewpassword"
  click_button "Login"
end

Then("I should receive an email") do
  open_email(@user.email)
  expect(current_email.subject).to eq "Password Changed"
end
