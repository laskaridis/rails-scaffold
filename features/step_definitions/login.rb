
Given("a confirmed user") do
  @user = create(:user, :with_confirmed_email, password: "password")
end

When("I log in with correct credentials") do
  visit new_user_session_path
  within("#login") do
    fill_in("user_email", with: @user.email)
    fill_in("user_password", with: "password")
  end
  click_button "Login"
end

Then("I should see my home page") do
  expect(page).to have_content "Signed in successfully"
  expect(page).to have_link @user.email
  expect(page).to have_link "Logout"
  expect(page).to have_link "Account"
end

When("I log in with incorrect credentials") do
  visit new_user_session_path
  within("#login") do
    fill_in("user_email", with: @user.email)
    fill_in("user_password", with: "invalid")
  end
  click_button "Login"
end

Then("I should see a message that my credentials are incorrect") do
  expect(page).to have_content "Invalid Email or password"
end

Given("an unconfirmed user") do
  @user = create(:user, :with_unconfirmed_email)
end

Then("I should see a message to confirm my email") do
  expect(page).to have_content "You have to confirm your email address before continuing"
end

