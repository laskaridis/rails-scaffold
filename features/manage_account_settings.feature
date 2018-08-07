Feature: Manage account settings

  Scenario: Update my country
    Given I am logged in
     When I visit my account settings
      And I update my country 
     Then my settings should be updated successfully

  Scenario: Update my currency
    Given I am logged in
     When I visit my account settings
      And I update my currency 
     Then my settings should be updated successfully

  Scenario: Update my language 
    Given I am logged in
     When I visit my account settings
      And I update my language 
     Then my settings should be updated successfully

  Scenario: Update my time zone
    Given I am logged in
     When I visit my account settings
      And I update my time zone 
     Then my settings should be updated successfully
