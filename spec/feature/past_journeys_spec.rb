# frozen_string_literal: true

require 'spec_helper'
require 'pry'

describe 'Past Journeys', :past_journeys do
  before(:each) do
    # login to app
    @app.login.login_with(user: Settings.valid_user, password: Settings.valid_password)
    # get code
    @valid_code = @app.code.code
    @app.code.next_button.click

    # Enter valid captcha
    @app.journey.captcha(value: @valid_code)

    # Journey page select origen and destination
    origin = 'Calle Pradillo, 42'
    destination = 'Aeropuerto Madrid Barajas, T4'
    @first_route = "#{origin} - #{destination}"

    @app.journey.set_dropdown(field: @app.journey.origin, value: origin)
    @app.journey.set_dropdown(field: @app.journey.destination, value: destination)

    # Estimate it
    @app.journey.estimate_button.click
    @first_price = @app.journey.price_field.text

    # Request car
    @app.journey.request_car_button.click
  end

  it 'request one car' do
    title = @app.request.title.text
    expect(title).to eql('Past Journeys')

    expect(@app.request.journeys.size).to eql 1

    first_journey = @app.request.journeys.first
    first_journey_route, first_journey_price = @app.request.journey_details(journey: first_journey)

    expect(@first_route).to eql(first_journey_route)
    expect(@first_price).to eql(first_journey_price)
  end

  it 'request multiple cars' do
    # back to Journey page
    back

    # select new destination
    origin = 'Calle Pradillo, 42'
    destination = 'Atocha'
    @last_route = "#{origin} - #{destination}"

    @app.journey.set_dropdown(field: @app.journey.origin, value: origin)
    @app.journey.set_dropdown(field: @app.journey.destination, value: destination)

    # Estimate it
    @app.journey.estimate_button.click
    @last_price = @app.journey.price_field.text

    # Request car
    @app.journey.request_car_button.click

    expect(@app.request.journeys.size).to eql 2

    last_journey = @app.request.journeys.last
    last_journey_route, last_journey_price = @app.request.journey_details(journey: last_journey)

    expect(@last_route).to eql(last_journey_route)
    expect(@last_price).to eql(last_journey_price)
  end
end
