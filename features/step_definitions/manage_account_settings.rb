When("I visit my account settings") do
  visit account_settings_path
  expect(page).to have_content "Edit Settings"
end

When("I update my country") do
  within "#account_settings" do
    select("Greece", from: "Country")
    click_button "Update settings"
  end
end

When("I update my currency") do
  within "#account_settings" do
    select("Euro", from: "Currency")
    click_button "Update settings"
  end
end

When("I update my language") do
  within "#account_settings" do
    select("English", from: "Language")
    click_button "Update settings"
  end
end

When("I update my time zone") do
  within "#account_settings" do
    select("(GMT+02:00) Athens", from: "Time zone")
    click_button "Update settings"
  end
end

Then("my country should be updated successfully") do
  expect(page).to have_content "Your profle has been updated"
  visit account_settings_path
  within "#account_settings" do
    expect(page).to have_select("Country", selected: "Greece")
  end
end

Then("my currency should be updated successfully") do
  expect(page).to have_content "Your profle has been updated"
  visit account_settings_path
  within "#account_settings" do
    expect(page).to have_select("Currency", selected: "Euro (€)")
  end
end

Then("my language should be updated successfully") do
  expect(page).to have_content "Your profle has been updated"
  visit account_settings_path
  within "#account_settings" do
    expect(page).to have_select("Language", selected: "English")
  end
end

Then("my time zone should be updated successfully") do
  expect(page).to have_content "Your profle has been updated"
  visit account_settings_path
  within "#account_settings" do
    expect(page).to have_select("Time zone", selected: "(GMT+02:00) Athens")
  end
end
