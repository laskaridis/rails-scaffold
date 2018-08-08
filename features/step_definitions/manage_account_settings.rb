When("I visit my account settings") do
  create(:country, code: :gr)
  create(:currency, code: :eur, symbol: "EUR")
  create(:language, code: :en)

  visit account_settings_path
  expect(page).to have_content "Edit Settings"
end

When("I update my country") do
  select("Greece", from: "Country")
  click_button "Update settings"
end

When("I update my currency") do
  select("Euro", from: "Currency")
  click_button "Update settings"
end

When("I update my language") do
  select("English", from: "Language")
  click_button "Update settings"
end

When("I update my time zone") do
  select("(GMT+02:00) Athens", from: "Time zone")
  click_button "Update settings"
end

Then("my country should be updated successfully") do
  expect(page).to have_content "Your profle has been updated"
  visit account_settings_path
  expect(page).to have_select("Country", selected: "Greece")
end

Then("my currency should be updated successfully") do
  expect(page).to have_content "Your profle has been updated"
  visit account_settings_path
  expect(page).to have_select("Currency", selected: "Euro")
end

Then("my language should be updated successfully") do
  expect(page).to have_content "Your profle has been updated"
  visit account_settings_path
  expect(page).to have_select("Language", selected: "English")
end

Then("my time zone should be updated successfully") do
  expect(page).to have_content "Your profle has been updated"
  visit account_settings_path
  expect(page).to have_select("Time zone", selected: "(GMT+02:00) Athens")
end
