Feature: Visit the homepage
  In order to navigate to Todo homepage
  As a website user
  I want to be able to visit and interact with the homepage

  Scenario: Lets find the homepage
    When I am on "/some/page"
    When I fill "username" with "doctor-vinnie@yahoo.ca"
    When I fill "password" with "password"
    When I press "login"

