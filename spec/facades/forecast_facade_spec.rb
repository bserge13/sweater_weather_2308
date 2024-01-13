require 'rails_helper'

RSpec.describe ForecastFacade do 
  it 'returns a forecast object', :vcr do 
    location = 'Wadesville, IN'
    weather = ForecastFacade.get_forecast(location) 

    expect(weather).to be_a Forecast
    expect(weather.current_forecast).to be_a Hash
    expect(weather.daily_forecast).to be_an Array
    expect(weather.daily_forecast.count).to eq 5
    expect(weather.hourly_forecast).to be_an Array
    expect(weather.hourly_forecast.count).to eq 24 
    expect(weather.id).to eq nil
    expect(weather.type).to be_a String 
    expect(weather.type).to eq 'forecast'
  end
end