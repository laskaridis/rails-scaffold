Given("I visit the home page") do
  visit root_path
  @view = LocalizationSettingsPage.new
end

When("I select region {string}") do |region|
  @view.select_region(region)
end

Then("region {string} should be applied") do |region|
  expect(@view.selected_region).to eq region
end

When("I select language {string}") do |language|
  @view.select_language(language)
end

When("I select currency {string}") do |currency|
  @view.select_currency(currency)
end

Given("I am a confirmed user") do
  @user = create :user, :with_confirmed_email
end

Given("my selected currency is {string}") do |currency_code|
  @user.update_attributes!(currency: Currency.find_by!(code: currency_code))
end

When("I log in") do
  visit new_user_session_path
  within("#login") do
    fill_in("user_email", with: @user.email)
    fill_in("user_password", with: "password")
  end
  click_button "Login"
end

Then("currency {string} should be applied") do |currency|
  expect(@view.selected_currency).to eq currency
end

Given("my selected region is {string}") do |country_code|
  @user.update_attributes!(country: Country.find_by!(code: country_code))
end

Given("my selected language is {string}") do |language_code|
  @user.update_attributes!(language: Language.find_by!(code: language_code))
end

Then("language {string} should be applied") do |language|
  expect(@view.selected_language).to eq language
end

Then("country {string} should be applied") do |country|
  expect(@view.selected_region).to eq country
end
