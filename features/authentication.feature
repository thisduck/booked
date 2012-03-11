Feature: Authentication
  As a site user
  I need to get into the site
  So that I can make help make this book

  Scenario: Sign in with twitter
    Given I am logged out
    When I log in
    Then I should be logged in
