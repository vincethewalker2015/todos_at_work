require 'capybara'
require 'capybara/cucumber'
require 'selenium-webdriver'
require 'pry'

Capybara.register_driver :chrome_headless do |app|
  options = Selenium::WebDriver::Chrome::Options.new(
    :args => %w[headless disable-gpu no-sandbox]
  )
  Capybara::Selenium::Driver.new(app, :browser => :chrome, :options => options)
end

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

Capybara.javascript_driver = :chrome
Capybara.javascript_driver = ENV['DRIVER'].to_sym if ENV['DRIVER']
Capybara.app_host          = 'https://young-springs-23919.herokuapp.com/'