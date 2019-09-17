# frozen_string_literal: true

class BaseLoginPage
  def login_with(user:, password:)
    # LoginPage.new
    user_field.send_keys(user)
    password_field.send_keys(password)
    login_button.click
  end

  def page_title
    # LoginPage.new
    action_bar_field.find_elements(class: 'android.widget.TextView').first.text
  end

  def alert_title
    alert_title_field.text
  end

  def alert_message
    alert_message_field.text
  end
end
