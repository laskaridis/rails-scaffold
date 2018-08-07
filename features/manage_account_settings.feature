Feature: Manage account settings

  Scenario: Update my country
    Given I am logged in
     When I visit my account settings
      And I update my country 
     Then my country should be updated successfully

  Scenario: Update my currency
    Given I am logged in
     When I visit my account settings
      And I update my currency 
     Then my currency should be updated successfully

  Scenario: Update my language 
    Given I am logged in
     When I visit my account settings
      And I update my language 
     Then my language should be updated successfully

  Scenario: Update my time zone
    Given I am logged in
     When I visit my account settings
      And I update my time zone 
     Then my time zone should be updated successfully
