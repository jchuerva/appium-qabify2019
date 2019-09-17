# frozen_string_literal: true

require 'spec_helper'
require 'pry'

describe 'Origen and destination dropdown fields', :fields do
  before(:each) do
    # login to app
    @app.login.login_with(user: Settings.valid_user, password: Settings.valid_password)
    @app.code.next_button.click
  end

  it 'select a valid origen and destination' do
    current_origin = @app.journey.selected_origin
    current_destination = @app.journey.selected_destination

    expect(@app.journey.selected_origin).to eql(current_origin)
    expect(@app.journey.selected_destination).to eql(current_destination)

    new_origin = 'Calle Pradillo, 42'
    new_destination = 'Atocha'

    @app.journey.set_dropdown(field: @app.journey.origin, value: new_origin)
    @app.journey.set_dropdown(field: @app.journey.destination, value: new_destination)

    expect(@app.journey.selected_origin).to eql(new_origin)
    expect(@app.journey.selected_destination).to eql(new_destination)
  end

  it 'select invalid origen' do
    current_origin = @app.journey.selected_origin
    expect(@app.journey.selected_origin).to eql(current_origin)

    new_origin = 'Calle Pradillo, 43'
    @app.journey.set_dropdown(field: @app.journey.origin, value: new_origin)

    expect(@app.journey.selected_origin).not_to eql(new_origin)
    expect(@app.journey.selected_origin).to eql(current_origin)
  end

  it 'select invalid destination' do
    current_destination = @app.journey.selected_destination
    expect(@app.journey.selected_destination).to eql(current_destination)

    new_destination = 'Calle Pradillo, 43'
    @app.journey.set_dropdown(field: @app.journey.destination, value: new_destination)

    expect(@app.journey.selected_origin).not_to eql(new_destination)
    expect(@app.journey.selected_origin).to eql(current_destination)
  end

  # Bug: it should not be possible to select same origin and destination
  skip 'same origin and destination' do
    origin = @app.journey.selected_origin
    destination = @app.journey.selected_destination

    expect(@app.journey.selected_origin).to eql(origin)
    expect(@app.journey.selected_destination).to eql(destination)

    new_origin = 'Calle Pradillo, 42'
    new_destination = 'Calle Pradillo, 42'

    @app.journey.set_dropdown(field: @app.journey.origin, value: new_origin)
    @app.journey.set_dropdown(field: @app.journey.destination, value: new_destination)

    expect(@app.journey.selected_origin).to eql(new_origin)
    expect(@app.journey.selected_destination).to eql(destination)
  end
end
