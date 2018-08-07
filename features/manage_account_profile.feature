Feature: Manage account profile

  Scenario: Update gender 
    Given I am logged in
     When I visit my account profile
      And I update my gender 
     Then my gender should be updated successfully

  Scenario: Update birth date
    Given I am logged in
     When I visit my account profile
      And I update my birth date 
     Then my birth date should be updated successfully
