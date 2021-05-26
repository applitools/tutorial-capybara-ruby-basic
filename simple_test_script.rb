require 'eyes_capybara'
require 'capybara/dsl'

extend Capybara::DSL

options = Selenium::WebDriver::Chrome::Options.new
options.add_argument('--headless') if ENV['CI'] == 'true'

runner = Applitools::ClassicRunner.new
batch = Applitools::BatchInfo.new('Demo Batch')
eyes = Applitools::Selenium::Eyes.new(runner: runner)

Applitools.register_capybara_driver :browser => :chrome, options:options

eyes.configure do |conf|
  conf.batch = batch
  conf.app_name = 'Demo App - capybara'
  conf.test_name = 'Smoke Test'
  conf.viewport_size = Applitools::RectangleSize.new(800, 600)
end

begin
  # Call Open on eyes to initialize a test session
  eyes.open(driver: page)

  # Navigate to the url we want to test
  visit('https://demo.applitools.com')

  # Note to see visual bugs, run the test using the above URL for the 1st run.
  # but then change the above URL to https://demo.applitools.com/index_v2.html (for the 2nd run)

  # check the login page
  eyes.check(name: 'Login window', target: Applitools::Selenium::Target.window.fully)

  # Click the 'Log In' button
  page.find(:id, 'log-in').click

  # Check the app page
  eyes.check(name: 'App Window', target: Applitools::Selenium::Target.window.fully)
  eyes.close
ensure
  eyes.abort_if_not_closed
  # Get and print all test results
  puts runner.get_all_test_results
end
