require 'rails_helper'

RSpec.describe Forecast do 
  before :each do 
    @location = 'Wadesville, IN'
    @weather = ForecastFacade.get_forecast(@location)
  end

  it 'exists with attributes', :vcr do 
    expect(@weather).to be_a Forecast
    expect(@weather.id).to eq(nil)
    expect(@weather.type).to eq("forecast")
    expect(@weather.current_forecast).to be_a Hash
    expect(@weather.daily_forecast).to be_an Array
    expect(@weather.hourly_forecast).to be_an Array
  end

  it 'has current forecast attributes', :vcr do
    expect(@weather.current_forecast).to have_key :last_updated
    expect(@weather.current_forecast[:last_updated]).to be_a String 
    expect(@weather.current_forecast).to have_key :temperature
    expect(@weather.current_forecast[:temperature]).to be_a Float 
    expect(@weather.current_forecast).to have_key :feels_like
    expect(@weather.current_forecast[:feels_like]).to be_a Float 
    expect(@weather.current_forecast).to have_key :humidity
    expect(@weather.current_forecast[:humidity]).to be_an Integer 
    expect(@weather.current_forecast).to have_key :uvi
    expect(@weather.current_forecast[:uvi]).to be_a Float 
    expect(@weather.current_forecast).to have_key :visibility
    expect(@weather.current_forecast[:visibility]).to be_a Float 
    expect(@weather.current_forecast).to have_key :condition
    expect(@weather.current_forecast[:condition]).to be_a String 
    expect(@weather.current_forecast).to have_key :icon
    expect(@weather.current_forecast[:icon]).to be_a String 
  end

  it 'has daily forecast attributes', :vcr do
    expect(@weather.daily_forecast.count).to eq 5
    expect(@weather.daily_forecast.first).to have_key :date
    expect(@weather.daily_forecast.first[:date]).to be_a String 
    expect(@weather.daily_forecast.first).to have_key :sunrise
    expect(@weather.daily_forecast.first[:sunrise]).to be_a String 
    expect(@weather.daily_forecast.first).to have_key :sunset
    expect(@weather.daily_forecast.first[:sunset]).to be_a String 
    expect(@weather.daily_forecast.first).to have_key :max_temp
    expect(@weather.daily_forecast.first[:max_temp]).to be_a Float 
    expect(@weather.daily_forecast.first).to have_key :min_temp
    expect(@weather.daily_forecast.first[:min_temp]).to be_a Float 
    expect(@weather.daily_forecast.first).to have_key :condition
    expect(@weather.daily_forecast.first[:condition]).to be_a String 
    expect(@weather.daily_forecast.first).to have_key :icon
    expect(@weather.daily_forecast.first[:icon]).to be_a String 
  end
  
  it 'has hourly forecast attributes', :vcr do
    expect(@weather.hourly_forecast.count).to eq 24
    expect(@weather.hourly_forecast.first).to have_key :time
    expect(@weather.hourly_forecast.first[:time]).to be_a String
    expect(@weather.hourly_forecast.first).to have_key :temperature
    expect(@weather.hourly_forecast.first[:temperature]).to be_a Float
    expect(@weather.hourly_forecast.first).to have_key :condition
    expect(@weather.hourly_forecast.first[:condition]).to be_a String
    expect(@weather.hourly_forecast.first).to have_key :icon
    expect(@weather.hourly_forecast.first[:icon]).to be_a String
  end
end