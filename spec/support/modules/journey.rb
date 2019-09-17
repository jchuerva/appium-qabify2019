# frozen_string_literal: true

class BaseJourneyPage
  def page_title
    title_field.text
  end

  def selected_origin
    dropdown_text(field: origin)
  end

  def selected_destination
    dropdown_text(field: destination)
  end

  def dropdown_text(field:)
    field.find_element(class: 'android.widget.TextView').text
  end

  def set_dropdown(field:, value:)
    # expand field
    field.click
    # get all possible values
    elems = @driver.find_elements(class: 'android.widget.TextView')
    options = elems.map(&:text)

    index = options.index(value)

    # click in option if it exists, if not click in title to close the dropdown options
    if index.nil?
      MOBILE.click_away
    else
      elems[index].click unless index.nil?
    end
  end

  def captcha(value:)
    captcha_text_field.send_keys(value)
    hide_keyboard
  end

  def check_field(field:)
    field.click unless field.checked?
  end

  def uncheck_field(field:)
    if field.checked?
      nil
    else
      field.click
    end
    #  if field.checked?
  end

  def alert_title
    alert_title_field.text
  end

  def alert_message
    alert_message_field.text
  end
end
