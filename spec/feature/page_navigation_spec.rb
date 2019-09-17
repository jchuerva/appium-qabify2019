# frozen_string_literal: true

require 'spec_helper'
require 'pry'

describe 'Navigation between pages', :navigation do
  before(:each) do
    # login to app
    @app.login.login_with(user: Settings.valid_user, password: Settings.valid_password)
    @code = @app.code.code

    # wait until the code page is loaded
    message = @app.code.message_text
    expect(message).to eql 'Remember this code for requesting a Taxi'
  end

  it 'from code page to login page and new code is generated' do
    # back to Login page
    back
    # ensure login page is displayed
    title = @app.login.page_title
    expect(title).to eql 'QAbify'

    user     = @app.login.user_field.text
    password = @app.login.password_field.text

    expect(user).to eql(Settings.valid_user)
    expect(password).to eql(Settings.valid_password)

    @app.login.login_button.click

    new_code = @app.code.code
    expect(new_code).not_to eql @code
  end

  it 'from journey to code page' do
    # click on next button
    @app.code.next_button.click

    # check page title
    title = @app.journey.page_title
    expect(title).to eql('Choose your journey settings')

    # back to Code page
    back

    message = @app.code.message_text
    expect(message).to eql 'Remember this code for requesting a Taxi'
    new_code = @app.code.code

    expect(new_code).to eql @code

    # click on next button
    @app.code.next_button.click

    # check page title
    title = @app.journey.page_title
    expect(title).to eql('Choose your journey settings')
  end

  it 'from past journeys to journew page' do
    # click on next button
    @app.code.next_button.click

    # Enter valid info in journey page
    origin = 'Calle Pradillo, 42'
    destination = 'Aeropuerto Madrid Barajas, T4'

    @app.journey.set_dropdown(field: @app.journey.origin, value: origin)
    @app.journey.set_dropdown(field: @app.journey.destination, value: destination)
    @app.journey.captcha(value: @code)

    @app.journey.estimate_button.click
    @app.journey.request_car_button.click

    title = @app.request.title.text
    expect(title).to eql('Past Journeys')

    # back
    back
    title = @app.journey.page_title
    expect(title).to eql('Choose your journey settings')
  end
end
