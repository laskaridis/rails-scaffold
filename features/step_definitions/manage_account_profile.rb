Given("I am logged in") do
  @user = create(:user, :with_confirmed_email)
  visit new_user_session_path
  within("#login") do
    fill_in("user_email", with: @user.email)
    fill_in("user_password", with: @user.password)
  end
  click_button "Login"
  expect(page).to have_content "Signed in successfully"
end

When("I visit my account profile") do
  visit account_profile_path
  expect(page).to have_content "Edit Profile"
end

When("I update my gender") do
  select("Female", from: "user_gender")
  click_button "Update profile"
end

Then("my gender should be updated successfully") do
  expect(page).to have_content "Your profle has been updated"
  visit account_profile_path
  expect(page).to have_select("user_gender", selected: "Female")
end

Then("my birth date should be updated successfully") do
  expect(page).to have_content "Your profle has been updated"
  visit account_profile_path
  expect(page).to have_select("user_birth_date_1i", selected: "2000")
  expect(page).to have_select("user_birth_date_2i", selected: "January")
  expect(page).to have_select("user_birth_date_3i", selected: "12")
end

When("I update my birth date") do
  select("2000", from: "user_birth_date_1i")
  select("January", from: "user_birth_date_2i")
  select("12", from: "user_birth_date_3i")
  click_button "Update profile"
end
