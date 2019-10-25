Feature: Is there a home page?
  Everybody wants to know if the website has a home page

  Scenario: Is there a Home page?
    Given there should be a home page
    When I click on the url
    Then I should be directed to the home page