Feature: Manage account preferences

  Background:
    Given I am logged in
      And I receive notifications by email
      And I visit by account preferences

  Scenario: Opt-out from notifications by email
     When I opt out from receiving email notifications
     Then my preferences should be updated successfully 

