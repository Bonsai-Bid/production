# spec/support/capybara.rb
require 'capybara/rspec'
require 'selenium-webdriver'

# Register ChromeDriver with Capybara
Capybara.register_driver :selenium_chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

# Register Headless ChromeDriver with Capybara (optional)
Capybara.register_driver :selenium_chrome_headless do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: Selenium::WebDriver::Chrome::Options.new(args: ['headless', 'disable-gpu', 'window-size=1400,1400']))
end

# Set the JavaScript driver to Chrome
Capybara.javascript_driver = :selenium_chrome
