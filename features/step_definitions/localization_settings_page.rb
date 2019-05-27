class LocalizationSettingsPage
  include Capybara::DSL

  def select_region(region)
    within "#localization_settings" do
      click_button "localization_settings_button"
    end
    within "#edit_localization_settings" do
      select(region, from: "Country")
      click_button "Save"
    end
  end

  def selected_region
    find("#selected_country").text
  end

  def select_language(language)
    within "#localization_settings" do
      click_button "localization_settings_button"
    end
    within "#edit_localization_settings" do
      select language, from: "Language"
      click_button "Save"
    end
  end

  def selected_language
    find("#selected_language").text
  end

  def select_currency(currency)
    within "#localization_settings" do
      click_button "localization_settings_button"
    end
    within "#edit_localization_settings" do
      select currency, from: "Currency"
      click_button "Save"
    end
  end

  def selected_currency
    find("#selected_currency").text
  end
end
