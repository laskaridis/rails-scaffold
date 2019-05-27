Feature: Manage account security

  Background:
    Given I am logged in
      And I visit my account security

  Scenario: Change my password successfully
     When I enter a new password 
     Then my password should change successfully
      And I should receive an email

