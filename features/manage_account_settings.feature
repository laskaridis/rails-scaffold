Feature: Manage account settings

  Background:
    Given I am logged in
      And I visit my account settings

  Scenario: Update my country
     When I update my country 
     Then my country should be updated successfully

  Scenario: Update my currency
     When I update my currency 
     Then my currency should be updated successfully

  Scenario: Update my language 
     When I update my language 
     Then my language should be updated successfully

  Scenario: Update my time zone
     When I update my time zone 
     Then my time zone should be updated successfully
