# frozen_string_literal: true

class BaseCodePage
  def message_text
    message_field.text
  end

  def code
    code_field.text
  end
end
