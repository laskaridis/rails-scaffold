Feature: Manage account profile

  Background:
    Given I am logged in
      And I visit my account profile

  Scenario: Update gender 
     When I update my gender 
     Then my gender should be updated successfully

  Scenario: Update birth date
     When I update my birth date 
     Then my birth date should be updated successfully
