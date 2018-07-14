Feature: Login

  As a user of the application
  I want to sign in
  To use its features

  Scenario: Successful login
    Given a confirmed user
     When I log in with correct credentials 
     Then I should see my home page

  Scenario: Incorrect credentials
    Given a confirmed user
     When I log in with incorrect credentials
     Then I should see a message that my credentials are incorrect

  Scenario: Unconfirmed user  
    Given an unconfirmed user
     When I log in with correct credentials
     Then I should see a message to confirm my email


