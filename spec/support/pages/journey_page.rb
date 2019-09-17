# frozen_string_literal: true

class JourneyPage < BaseJourneyPage
  def title_field
    # ask development team for a unique locator
    find_element(id: 'content').find_elements(class: 'android.widget.TextView').first
  end

  def origin
    find_element(id: 'pick_up_point')
  end

  def destination
    find_element(id: 'drop_off_point')
  end

  def lite_checkbox
    find_element(id: 'liteCheckBox')
  end

  def executive_checkbox
    find_element(id: 'executiveCheckBox')
  end

  def captcha_text_field
    find_element(id: 'captcha_text')
  end

  def price_field
    find_element(id: 'price_text')
  end

  def estimate_button
    find_element(id: 'estimate_button')
  end

  def request_car_button
    find_element(id: 'request_button')
  end

  def alert_title_field
    find_element(id: 'alertTitle')
  end

  def alert_message_field
    find_element(id: 'message')
  end
end
