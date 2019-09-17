# frozen_string_literal: true

require 'spec_helper'
require 'pry'

# not sure it the info should be displayed after restar the app
describe 'Navigation between pages', :actions do
  it 'close and open app in the login page' do
    # check LoginPage title
    title = @app.login.page_title
    expect(title).to eql 'QAbify'

    close_app
    launch_app

    expect(@app.login.page_title).to eql 'QAbify'

    @app.login.enter_login_info(user: Settings.valid_user, password: Settings.valid_password)

    close_app
    launch_app

    user     = @app.login.user_field.text
    password = @app.login.password_field.text

    expect(user).to eql('Username')
    expect(password).to eql('Password')
  end

  it 'close and open app in the code page' do
    @app.login.login_with(user: Settings.valid_user, password: Settings.valid_password)

    message = @app.code.message_text
    expect(message).to eql 'Remember this code for requesting a Taxi'

    close_app
    launch_app

    expect(@app.login.page_title).to eql 'QAbify'
  end

  it 'close and open app in the journey page' do
    @app.login.login_with(user: Settings.valid_user, password: Settings.valid_password)

    @app.code.next_button.click

    # check page title
    expect(@app.journey.page_title).to eql('Choose your journey settings')

    close_app
    launch_app

    expect(@app.login.page_title).to eql 'QAbify'
  end

  it 'close and open app in the journey page after estimate it' do
    @app.login.login_with(user: Settings.valid_user, password: Settings.valid_password)

    @valid_code = @app.code.code
    @app.code.next_button.click

    origin = 'Calle Pradillo, 42'
    destination = 'Aeropuerto Madrid Barajas, T4'
    @app.journey.set_dropdown(field: @app.journey.origin, value: origin)
    @app.journey.set_dropdown(field: @app.journey.destination, value: destination)
    @app.journey.captcha(value: @valid_code)
    @app.journey.estimate_button.click

    expect(@app.journey.page_title).to eql('Choose your journey settings')

    close_app
    launch_app

    expect(@app.login.page_title).to eql 'QAbify'
  end

  it 'close and open app in the past journey page' do
    @app.login.login_with(user: Settings.valid_user, password: Settings.valid_password)

    @valid_code = @app.code.code
    @app.code.next_button.click

    origin = 'Calle Pradillo, 42'
    destination = 'Aeropuerto Madrid Barajas, T4'
    @app.journey.set_dropdown(field: @app.journey.origin, value: origin)
    @app.journey.set_dropdown(field: @app.journey.destination, value: destination)
    @app.journey.captcha(value: @valid_code)
    @app.journey.estimate_button.click
    @app.journey.request_car_button.click

    title = @app.request.title.text
    expect(title).to eql('Past Journeys')

    close_app
    launch_app

    expect(@app.login.page_title).to eql 'QAbify'
  end
end
