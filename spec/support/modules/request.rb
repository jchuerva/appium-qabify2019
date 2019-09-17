# frozen_string_literal: true

class BaseRequestCarPage
  def journey_price(journey:)
    journey.find_element(id: 'journeyPrice').text
  end

  def journey_route(journey:)
    journey.find_element(id: 'journeyTitle').text
  end

  def journey_details(journey:)
    [journey.find_element(id: 'journeyTitle').text, journey.find_element(id: 'journeyPrice').text]
  end
end
