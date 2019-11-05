Feature: Visit the homepage
  In order to navigate to Todo homepage
  As a website user
  I want to be able to visit and interact with the homepage

  Scenario: Lets find the homepage
    When I am on "/some/page"
    When I fill "username" with "everzet"
    When I fill "password" with "123456"
    When I press "login"

