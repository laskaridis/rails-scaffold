Feature: Manage account preferences

  Scenario: Opt-out from notifications by email
    Given I am logged in
      And I receive notifications by email
     When I visit by account preferences
      And I opt out from receiving email notifications
     Then my preferences should be updated successfully 

