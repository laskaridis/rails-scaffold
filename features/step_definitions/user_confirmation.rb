Given("I register successfully") do
  clear_emails
  visit new_user_registration_path
  @user = build(:user)
  fill_in "user_email", with: @user.email
  fill_in "user_password", with: @user.password
  fill_in "user_password_confirmation", with: @user.password
  click_button "Register"
end

Given("I have received a user confirmation email") do
  open_email(@user.email)
  expect(current_email.subject).to eq "Confirmation instructions"
end

When("I click on the user confirmation email link") do
  current_email.click_link("Confirm my account")
end

Then("I should be confirmed") do
  expect(page).to have_content "Your email address has been successfully confirmed"
end
