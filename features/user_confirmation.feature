Feature: User confirmation

  Scenario: Successful user confirmation
    Given I register successfully
      And I have received a user confirmation email
     When I click on the user confirmation email link
     Then I should be confirmed
