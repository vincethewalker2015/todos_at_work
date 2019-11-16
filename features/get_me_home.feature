Feature: Visit the homepage
  In order to navigate in Todos at Work
  As a website user
  I want to be able to visit and interact with the homepage and log in

  Scenario: Find the Home Page and Login
    Given I am on the home page
    Then I should see "Todos At Work"
    And I should see "log In"
    When I click on the first ".btn"
    And I should see "Log In Here"
    
    

  