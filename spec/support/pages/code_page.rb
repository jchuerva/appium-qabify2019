# frozen_string_literal: true

class CodePage < BaseCodePage
  def message_field
    find_element(id: 'content').find_elements(class: 'android.widget.TextView').first
  end

  def code_field
    find_element(id: 'captcha_text')
  end

  def next_button
    find_element(id: 'captcha_button')
  end
end
