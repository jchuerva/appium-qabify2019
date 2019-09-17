# frozen_string_literal: true

# Mobile helper methods
module MOBILE
  def self.click_away
    Appium::TouchAction.new.tap(x: 1021, y: 866).perform
  end

  def self.expose_and_open
    press_keycode(187)
    sleep(2)
    press_keycode(187)
  end
end
