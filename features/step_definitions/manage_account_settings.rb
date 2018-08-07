When("I visit my account settings") do
  create(:country, code: :gr)
  create(:currency, code: :eur, symbol: "EUR")
  create(:language, code: :en)

  visit user_settings_path
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

Then("my settings should be updated successfully") do
  expect(page).to have_content "Your profle has been updated"
end
