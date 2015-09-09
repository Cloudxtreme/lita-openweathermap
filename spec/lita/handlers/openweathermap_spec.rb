require "spec_helper"

describe Lita::Handlers::Openweathermap, lita_handler: true do

  before do
    Lita.config.handlers.openweathermap.metric = 'metric'
  end

  it { routes_command("weather city, coountry").to(:weather) }

  it "checks valid city and country arguments" do
    send_command "weather city"
    expect(replies.last).to be_nil

    send_command "weather city county"
    expect(replies.last).to be_nil

    send_command "weather city, county"
    expect(replies.last).not_to be_nil
  end

  it "should respond with valid weather informations" do
    send_command "weather berlin, germany"
    expect(replies.last).not_to be_nil
    expect(replies.last).to include("Weather for: Berlin Germany")
  end

end
