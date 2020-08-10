require 'eyes_capybara'
require 'capybara/dsl'

extend Capybara::DSL

runner = Applitools::ClassicRunner.new
batch = Applitools::BatchInfo.new('Demo Batch')
eyes = Applitools::Selenium::Eyes.new(runner: runner)

Applitools.register_capybara_driver :browser => :chrome

eyes.configure do |conf|
  conf.batch = batch
  conf.app_name = 'Demo App'
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
  eyes.check_window('Login window')

  # Click the 'Log In' button
  page.find(:id, 'log-in').click

  # Check the app page
  eyes.check_window('App Window')
  eyes.close
ensure
  eyes.abort_if_not_closed
  # Get and print all test results
  puts runner.get_all_test_results
end
