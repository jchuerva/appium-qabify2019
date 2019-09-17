# frozen_string_literal: true

require 'spec_helper'
require 'pry'

describe 'Journey page', :journey do
  before(:each) do
    # login to app
    @app.login.login_with(user: Settings.valid_user, password: Settings.valid_password)
    # get code
    @valid_code = @app.code.code
    @app.code.next_button.click

    # Journey page select origen and destination
    origin = 'Calle Pradillo, 42'
    destination = 'Aeropuerto Madrid Barajas, T4'
    @route = "#{origin} - #{destination}"

    @app.journey.set_dropdown(field: @app.journey.origin, value: origin)
    @app.journey.set_dropdown(field: @app.journey.destination, value: destination)
  end

  it 'enter an invalid captcha code' do
    invalid_code = 1234
    @app.journey.captcha(value: invalid_code)

    # click on stimate button
    @app.journey.estimate_button.click

    expect(@app.journey.alert_title).to eql('Error in captcha!')
    expect(@app.journey.alert_message).to eql('Captcha typed is wrong')
  end

  it 'choose lite type of car' do
    @app.journey.captcha(value: @valid_code)

    # select lite type of car
    # @app.journey.select_only_type(type: 'lite')

    # click on stimate button
    @app.journey.estimate_button.click
    price = @app.journey.price_field.text

    valid_price?(price: price)

    # Request car
    @app.journey.request_car_button.click
    title = @app.request.title.text
    expect(title).to eql('Past Journeys')

    first_journey = @app.request.journeys.first
    first_journey_route, first_journey_price = @app.request.journey_details(journey: first_journey)

    expect(@route).to eql(first_journey_route)
    expect(price).to eql(first_journey_price)
  end

  it 'choose executive type of car' do
    @app.journey.captcha(value: @valid_code)

    # select executive type of car
    @app.journey.lite_checkbox.click
    @app.journey.executive_checkbox.click

    # click on stimate button
    @app.journey.estimate_button.click
    price = @app.journey.price_field.text

    valid_price?(price: price)

    # Request car
    @app.journey.request_car_button.click
    title = @app.request.title.text
    expect(title).to eql('Past Journeys')

    first_journey = @app.request.journeys.first
    first_journey_route, first_journey_price = @app.request.journey_details(journey: first_journey)

    expect(@route).to eql(first_journey_route)
    expect(price).to eql(first_journey_price)
  end

  it 'choose lite and executive type of car' do
    @app.journey.captcha(value: @valid_code)

    # select executive type of car
    @app.journey.executive_checkbox.click

    # click on stimate button
    @app.journey.estimate_button.click
    price = @app.journey.price_field.text

    valid_price?(price: price)
  end

  it 'do not select any type of car' do
    @app.journey.captcha(value: @valid_code)

    # unselect lite type of car
    @app.journey.lite_checkbox.click

    # click on stimate button
    @app.journey.estimate_button.click
    price = @app.journey.price_field.text

    valid_price?(price: price)
  end

  it 'compare lite and executive price' do
    @app.journey.captcha(value: @valid_code)

    # click on stimate button
    @app.journey.estimate_button.click
    lite_price = @app.journey.price_field.text

    # select executive type of car
    @app.journey.lite_checkbox.click
    @app.journey.executive_checkbox.click

    # click on stimate button
    @app.journey.estimate_button.click
    executive_price = @app.journey.price_field.text

    expect(lite_price < executive_price).to be true
  end

  # bug: currently it's possible to request a car without stimate it
  skip 'estimate a second car before request it: change destination' do
    # Estimate and request the first car
    @app.journey.estimate_button.click
    @first_price = @app.journey.price_field.text
    @app.journey.request_car_button.click

    # back
    back

    # modify the destination
    new_destination = 'Atocha'
    @app.journey.set_dropdown(field: @app.journey.destination, value: new_destination)

    # check request button is not enabled
    expect(@app.journey.request_car_button.enabled?).to be false
  end

  # bug: currently it's possible to request a car without stimate it
  skip 'estimate a second car before request it: change type' do
    # Estimate and request the first car
    @app.journey.estimate_button.click
    @first_price = @app.journey.price_field.text
    @app.journey.request_car_button.click

    # back
    back

    # modify the car type
    @app.journey.lite_checkbox.click
    @app.journey.executive_checkbox.click

    # check request button is not enabled
    expect(@app.journey.request_car_button.enabled?).to be false
  end

  def valid_price?(price:)
    price.include?('€')
    money = price.split(' ').first.to_f
    expect(money.positive?).to be true
  end
end
