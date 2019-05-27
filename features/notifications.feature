Feature: Notifications 

  Scenario: Display notification alert 
    Given I am a user having three unread notifications
     When I log in
     Then I should see a badge warning me about three unread notifications

  Scenario: Read my notifications
    Given I am a user with three notifications
     When I log in
      And list my notifications
     Then I should see my three notifications
