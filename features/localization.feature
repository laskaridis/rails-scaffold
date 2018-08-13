Feature: Localization

  Scenario: Default country
    When I visit the home page
    Then country "-" should be applied

  Scenario: Default currency
    When I visit the home page
    Then currency "Euro" should be applied

  Scenario: Default language
    When I visit the home page
    Then language "English" should be applied

  Scenario: Change my currency
    Given I visit the home page
      And currency "Euro" is selected 
     When I select currency "US Dollar"
     Then currency "US Dollar" should be applied

  Scenario: Change my region
    Given I visit the home page
      And I have not selected any region
     When I select region "Greece"
     Then region "Greece" should be applied

  Scenario: Change my language
    Given I visit the home page
      And language "English" is selected
     When I select language "Ελληνικά"
     Then language "Ελληνικά" should be applied

  Scenario: Set the currency from my settings when I log in
    Given I am a confirmed user
      And my selected currency is "USD"
     When I log in
     Then currency "US Dollar" should be applied

  Scenario: Set the region from my settings when I log in
    Given I am a confirmed user
      And my selected region is "gr"
     When I log in
     Then region "Greece" should be applied

  Scenario: Set the language from my settings when I log in
    Given I am a confirmed user
      And my selected language is "en"
     When I log in
     Then language "English" should be applied


