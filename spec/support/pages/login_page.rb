# frozen_string_literal: true

class LoginPage < BaseLoginPage
  def action_bar_field
    find_element(id: 'action_bar')
  end

  def user_field
    find_element(id: 'user_name_edit_text')
  end

  def password_field
    find_element(id: 'password_edit_text')
  end

  def login_button
    find_element(id: 'login_button')
  end

  def alert_title_field
    find_element(id: 'alertTitle')
  end

  def alert_message_field
    find_element(id: 'message')
  end
end
