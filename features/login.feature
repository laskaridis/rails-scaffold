Feature: Login

  As a user of the application
  I want to sign in
  To use its features

  Scenario: Successful login
    Given a confirmed user
     When I log in with correct credentials 
     Then I should see my home page
      And I should be logged in

  Scenario: Incorrect credentials
    Given a confirmed user
     When I log in with incorrect credentials
     Then I should see a message that my credentials are incorrect
      And I should not be logged in

  Scenario: Unconfirmed user  
    Given an unconfirmed user
     When I log in with correct credentials
     Then I should see a message to confirm my email
      And I should not be logged in

  Scenario: Login with google account
    Given a user with a google account
     When I visit the login page
      And I choose to login with google
     Then I should log in sucessfully


