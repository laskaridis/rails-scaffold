Feature: Manage account security

  Scenario: Change my password
    Given I am logged in
     When I visit my account security
      And I enter a new password 
     Then my password should change successfully
