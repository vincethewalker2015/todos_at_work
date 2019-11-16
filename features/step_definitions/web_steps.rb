When(/^debug here$/) do
  binding.pry
end

screenshot_seq = 0
When(/I have a screenshot$/) do
    screenshot_seq++
    save_screenshot("screenshot#{screenshot_seq}.jpg", full: true)
end

Given /^I am on the home page$/ do
  visit('/')
end

Given /^I am on the memberships page$/ do
  visit('/ememberships')
end

Given(/^I am on the Membership checkout page$/) do
  visit('/checkout/emembership')
end

Given(/^I have accepted cookies$/) do
  click_button('Accept')
end

Then(/^I will click on to log in$/) do
  click_button('Log In')
end

When /^I enter "([^"]*)" into the "([^"]*)" field$/ do |text, field|
  fill_in field, :with => text
end

Then /^I should see "([^"]*)"$/ do |text|
  if text == "booking_reference"
    page.should have_content(@booking)
  else
    page.assert_text :visible, text
  end
end

Then /^the current path should be "([^"]*)"$/ do |path|
  fail("Expected #{current_path}, instead got #{path}") unless current_path == path
end

When(/^I proceed to checkout/) do
  all(".book-now").first.click
end

When(/^I press "([^"]*)"$/) do |button|
  click_button(button)
end

When(/^I press-on "([^"]*)"$/) do |button|
  click_button(button)
end

When(/^I press the first "([^"]*)" button$/) do |button|
  first(:button, button).click
end

Given(/^I am on the hostel page for "(.*?)"$/) do |hostel_slug|
  visit("/hostels/#{hostel_slug}")
end

When(/^I select tab "(.*?)"$/) do |tab|
  click_on(tab.capitalize)
end

When(/^I select link "(.*?)"$/) do |link|
  click_on(link)
end

When(/^I select the first link "(.*?)"$/) do |link|
  click_link(link, :match => :first)
end

When(/^I choose "(.*?)" from the radio buttons/) do |radio_button|
  page.execute_script %($("##{radio_button}").click())
end

When(/^I click on the last "(.*?)"$/) do |class_to_click|
  all(class_to_click).last.click
end

When(/^I click on the first "(.*?)"$/) do |class_to_click|
  all("#{class_to_click}:enabled").first.click
end

Then(/^save and open page$/) do
  save_and_open_page
end

When(/^I select "(.*?)" from "(.*?)"$/) do |option, list|
  all(list).last.select(option)
end

Then(/^I should not see "(.*?)"$/) do |text|
  page.should have_no_content(text)
end

When(/^I check "(.*?)"$/) do |check_box|
  check(check_box)
end

When(/^I press "(.*?)" in the "(.*?)" field$/) do |key, field|
  case key
  when 'enter'
    find_field(field).native.send_keys(:enter)
  end
end

When(/^I wait for (\d+) seconds$/) do |secs|
  sleep(secs.to_i)
end

Then(/^I should remember the booking number$/) do
  @booking = text.match(/reference: (\d+)/)[1]
end

Then(/^I should remember the eMembership booking reference$/) do
  @eMembership = text.match(/reference: (\d+)/)[1]
end

Given(/^I am logged in$/) do
  steps %Q{
    When I select link "Login"
    Then I should see "Account log in"
    When I enter "testingpage@hihostels.com" into the "session_request_email" field
    And I enter "bookertest" into the "Password" field
    And I press "Login"
    Then I should see "You were successfully logged in."
  }
end

Given(/^I select a dorm from the grid/) do
  steps %Q{
    Given I am on the hostel page for "vik"
    Then I should see "Coed/Mixed 6 Person Dorm"
    When I click on the first ".checkbox"
    Then I should see "number of guests"
    When I select "1" from ".guest-select"
    And I press the first "Confirm" button
    Then I should see "You have selected"
  }
end

Given(/^I select a room from the grid/) do
  steps %Q{
    Given I am on the hostel page for "vik"
    Then I should see "2 Person Private Room"
    When I click on the last ".checkbox"
    Then I should see "Number of rooms"
    When I select "1" from ".room-quantity"
    Then I should see "Confirm"
    When I select "1" from ".guest-select"
    And I press the first "Confirm" button
    Then I should see "You have selected"
  }
end

Given(/^I make a payment/) do
  steps %Q{
    When I enter "5454545454545454" into the "cardNumber" field
    And I enter "Test User" into the "cardholderName" field
    And I enter "01" into the "expiryMonth" field
    And I enter "30" into the "expiryYear" field
    And I enter "123" into the "securityCode" field
    And I press "Make Payment"
  }
end

Given(/^I have a booking$/) do
  steps %Q{
    Given I select a dorm from the grid
    When I proceed to checkout
    Then I should see "You may want to add these optional products to your booking."
    When I check "I agree to the Booking and Cancellation / No-show Terms & Conditions"
    And I press "Pay securely now"
    Then I should see "Payment"
    When I make a payment
    And I wait for 15 seconds
    Then I should see "SUCCESS!"
    And I should see "Your reference:"
    And I should remember the booking number
  }
end

Given(/^I have an HI Membership$/) do
  steps %Q{
    And I am on the Membership checkout page
    Then I should see "HI Membership"
    And I should have 1 of "emembership-quantity" class
    When I select "1" from ".emembership-quantity"
    Then I should see "Please provide the country of residence for each guest"
    And I should have 1 of "emembership-option" class
    When I select "Argentina" from ".emembership-option"
    And I press "Buy Now"
    Then I should see "Payment"
    When I click on the last ".checkbox"
    And I press "Pay by card"
    And I make a payment
    And I wait for 10 seconds
    Then I should see "Activate your Membership(s)"
    And I should see "Read your Membership Terms and Conditions"
  }
end

Given(/^I have an active HI Membership$/) do
  steps %Q{
    When I have an HI Membership
    And I am on the memberships page
    Then I should see "Membership"
    And I should see "Not activated"
    And I should see "Activate"
    When I select the first link "Activate"
    Then I should see "Activate Membership"
    When I choose "m0" from the radio buttons
    And I press "Next »"
    Then I should see "Activate Membership"
    When I select "12" from "#dob_day"
    And I select "April" from "#dob_month"
    And I select "1988" from "#dob_year"
    And I enter "blue street" into the "street" field
    And I enter "se4" into the "postcode" field
    And I enter "london" into the "city" field
    And I select "Argentina" from "#country"
    And I enter "name@domain.com" into the "email" field
    And I press "Activate »"
    Then I should see "Membership"
    And I should see "Activated"
    And I should see "Edit"
  }
end

When(/^I view the remembered booking$/) do
  visit("/customers/bookings/#{@booking}")
end

When(/^I find a hostel with at least (.*?) reviews$/) do |reviews|
  steps %Q{
    When I press "Search"
    Then I should see "HOSTELS ("
  }
  while (more_than = page.text.scan(/(\d+) Reviews/).flatten.collect{ |i| i.to_i}.max) < reviews.to_i do
  # while (more_than = all('.reviews').collect{|p|p.text[0].to_i}.max) < reviews.to_i do

    step %Q{I select link "Show more"}
  end
  step %Q{I select link "#{more_than} Reviews"}
end

Then(/^I should have (.*?) of "(.*?)" class$/) do |occ_count, css_class|
  operator = "=="
  if !(occ_count[0] =~ /[0-9]/)
    operator = occ_count[0]
    want = occ_count[1..-1].to_i
  else
    want = occ_count.to_i
  end

  have = page.all(".#{css_class}").count
  unless eval "#{have} #{operator} #{want}"
    fail("Expected #{want} elements of class '#{css_class}', instead found #{have} elements.")
  end
end

Then(/^I should have 1 of "(.*?)" id$/) do |id|
  fail("Expected 1 element of id #{id} instead found 0") unless page.all("##{id}").count
end




















