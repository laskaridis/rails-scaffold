Feature: Localization

  Background:
    Given I visit the home page

  Scenario: Default country
    Then country "-" should be applied

  Scenario: Default currency
    Then currency "Euro (€)" should be applied

  Scenario: Default language
    Then language "English" should be applied

  Scenario: Change my currency
     When I select currency "US Dollar"
     Then currency "US Dollar ($)" should be applied

  Scenario: Change my region
     When I select region "Greece"
     Then region "Greece" should be applied

  Scenario: Change my language
     When I select language "Ελληνικά"
     Then language "Ελληνικά (Greek)" should be applied

  Scenario: Set the currency from my settings when I log in
    Given I am a confirmed user
      And my selected currency is "USD"
     When I log in
     Then currency "US Dollar ($)" should be applied

  Scenario: Set the region from my settings when I log in
    Given I am a confirmed user
      And my selected region is "gr"
     When I log in
     Then region "Greece" should be applied

  Scenario: Set the language from my settings when I log in
    Given I am a confirmed user
      And my selected language is "el"
     When I log in
     Then language "Ελληνικά (Greek)" should be applied


