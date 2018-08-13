Given("I visit the home page") do
  visit root_path
end

Given("I have not selected any region") do
  within "#selected_country" do
    expect(page).to have_content "-"
  end
end

When("I select region {string}") do |region|
  within "#localization_settings" do
    click_button "localization_settings_button"
  end
  within "#edit_localization_settings" do
    select(region, from: "Country")
    click_button "Save"
  end
end

Then("region {string} should be applied") do |region|
  within "#selected_country" do
    expect(page).to have_content region
  end
end

When("I select language {string}") do |language|
  within "#localization_settings" do
    click_button "localization_settings_button"
  end
  within "#edit_localization_settings" do
    select language, from: "Language"
    click_button "Save"
  end
end

When("I select currency {string}") do |currency|
  within "#localization_settings" do
    click_button "localization_settings_button"
  end
  within "#edit_localization_settings" do
    select currency, from: "Currency"
    click_button "Save"
  end
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
  within "#selected_currency" do
    expect(page).to have_content currency
  end
end

Given("my selected region is {string}") do |country_code|
  @user.update_attributes!(country: Country.find_by!(code: country_code))
end

Given("my selected language is {string}") do |language_code|
  @user.update_attributes!(language: Language.find_by!(code: language_code))
end

Then("language {string} should be applied") do |language|
  within "#selected_language" do
    expect(page).to have_content language
  end
end

Given("currency {string} is selected") do |currency|
  within "#selected_currency" do
    expect(page).to have_content currency
  end
end

Given("language {string} is selected") do |language|
  within "#selected_language" do
    expect(page).to have_content language
  end
end

Then("country {string} should be applied") do |country|
  within "#selected_country" do
    expect(page).to have_content country
  end
end
