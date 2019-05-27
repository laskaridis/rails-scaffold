Feature: Password reset

  Background:
    Given I have confirmed my email 

  Scenario: Request password change
     When I request a password reset
     Then I should receive an password reset email

  Scenario: Change password 
    Given I have received a pasword reset email
     When I click on the password reset link on the email
      And I change my password
     Then I should be able to login with my new password

