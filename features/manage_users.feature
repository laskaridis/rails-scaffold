Feature: Manage users

  As an administrator, I want to manage the application's users

  Background:
    Given the following registered users:
      | user email      |
      | user1@localhost |
      | user2@localhost |
      | user3@localhost |

  Scenario: List users
    Given I am an administrator
    When I vist the users administration page
    Then I should see all the registered users

