# frozen_string_literal: true

require 'appium_lib'
require 'require_all'

RSpec.configure do |config|
  config.before(:each) do
    @caps = Appium.load_appium_txt file: File.expand_path('../devices/android9.txt', __dir__), verbose: true

    @driver = Appium::Driver.new(@caps, true)
    @driver.start_driver
    Appium.promote_appium_methods Object

    @app = Pages.new
  end

  config.after(:each) do
    @driver.driver_quit
  end
end
