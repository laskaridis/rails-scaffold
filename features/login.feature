Feature: Login

  Scenario: Successful login
    Given I have confirmed my email
     When I log in with correct credentials 
     Then I should see my home page
      And I should be logged in

  Scenario: Incorrect credentials
    Given I have confirmed my email
     When I log in with incorrect credentials
     Then I should see a message that my credentials are incorrect
      And I should not be logged in

  Scenario: Unconfirmed user  
    Given I haven't confirmed my email
     When I log in with correct credentials
     Then I should see a message to confirm my email
      And I should not be logged in

  Scenario: Login with google account
    Given I have a google account
     When I visit the login page
      And I choose to login with google
     Then I should log in sucessfully


