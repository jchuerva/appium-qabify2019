# frozen_string_literal: true

class RequestCarPage < BaseRequestCarPage
  def title
    find_element(id: 'content').find_elements(class: 'android.widget.TextView').first
  end

  def journeys
    find_elements(id: 'JourneyLayout')
  end
end
