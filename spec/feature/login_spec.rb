# frozen_string_literal: true

require 'spec_helper'
require 'pry'

describe 'Login page', :login do
  it 'entering a valid user and password' do
    # check LoginPage title
    title = @app.login.page_title
    expect(title).to eql 'QAbify'

    # enter valid values
    @app.login.login_with(user: Settings.valid_user, password: Settings.valid_password)

    # CodePage
    message = @app.code.message_text
    expect(message).to eql 'Remember this code for requesting a Taxi'

    code = @app.code.code
    expect(code.size).to eql 3
  end

  it 'entering an invalid user and valid password' do
    # check LoginPage title
    title = @app.login.page_title
    expect(title).to eql 'QAbify'

    # enter valid values
    @app.login.login_with(user: 'invalid@qabify.com', password: '1234Abc')

    expect(@app.login.alert_title).to eql('Bad Login')
    expect(@app.login.alert_message).to eql('User name or Password is not correct')
  end

  it 'entering a valid user and invalid password' do
    # check LoginPage title
    title = @app.login.page_title
    expect(title).to eql 'QAbify'

    # enter valid values
    @app.login.login_with(user: 'user@qabify.com', password: '1234')

    expect(@app.login.alert_title).to eql('Bad Login')
    expect(@app.login.alert_message).to eql('User name or Password is not correct')
  end

  it 'entering an invalid user and password' do
    # check LoginPage title
    title = @app.login.page_title
    expect(title).to eql 'QAbify'

    # enter valid values
    @app.login.login_with(user: 'invalid@qabify.com', password: '1234')

    expect(@app.login.alert_title).to eql('Bad Login')
    expect(@app.login.alert_message).to eql('User name or Password is not correct')
  end
end
