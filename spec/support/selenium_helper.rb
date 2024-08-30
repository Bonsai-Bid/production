# spec/support/selenium_helper.rb
module SeleniumHelper
  def setup_chrome_driver
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--start-maximized')  # Start Chrome maximized
    # options.add_argument('--headless')  # Uncomment to run in headless mode

    Selenium::WebDriver.for :chrome, options: options
  end
end
