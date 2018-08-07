When("I request a password reset") do
  visit new_user_session_path
  clear_emails
  click_link "Forgot your password?"
  fill_in "user_email", with: @user.email
  click_button "Send me reset password instructions"
end

Then("I should receive an password reset email") do
  open_email(@user.email)
  expect(current_email.subject).to eq "Reset password instructions"
end

Given("I have received a pasword reset email") do
  visit new_user_session_path
  clear_emails
  click_link "Forgot your password?"
  fill_in "user_email", with: @user.email
  click_button "Send me reset password instructions"
end

When("I click on the password reset link on the email") do
  open_email(@user.email)
  current_email.click_link "Change my password"
end

When("I change my password") do
  fill_in "user_password", with: "mynewpassword"
  fill_in "user_password_confirmation", with: "mynewpassword"
  click_button "Change my password"
end

Then("I should be able to login with my new password") do
  visit new_user_session_path
  fill_in "user_email", with: @user.email
  fill_in "user_password", with: "mynewpassword"
  click_button "Login"
  expect(page).to have_content "Signed in successfully"
end
