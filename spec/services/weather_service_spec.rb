require 'rails_helper'

RSpec.describe WeatherService do 
  describe 'Weather Forecasts' do 
    it "returns current weather data for a location with it's lat/lng", :vcr do 
      weather = WeatherService.current_forecast(38.10984, -87.78929)
      expect(weather).to be_a Hash
      expect(weather).to have_key :location 
      expect(weather).to have_key :current
      expect(weather[:location]).to have_key :name
      expect(weather[:location][:name]).to be_a String
      expect(weather[:current]).to be_a Hash 
      expect(weather[:current]).to have_key :last_updated
      expect(weather[:current][:last_updated]).to be_a String
      expect(weather[:current]).to have_key :temp_f
      expect(weather[:current][:temp_f]).to be_a Float 
      expect(weather[:current]).to have_key :condition
      expect(weather[:current][:condition]).to be_a Hash
      expect(weather[:current][:condition]).to have_key :text
      expect(weather[:current][:condition][:text]).to be_a String
      expect(weather[:current][:condition]).to have_key :icon 
      expect(weather[:current][:condition][:icon]).to be_a String
      expect(weather[:current]).to have_key :humidity 
      expect(weather[:current][:humidity]).to be_an Integer
      expect(weather[:current]).to have_key :feelslike_f
      expect(weather[:current][:feelslike_f]).to be_a Float
      expect(weather[:current]).to have_key :vis_miles
      expect(weather[:current][:vis_miles]).to be_a Float
      expect(weather[:current]).to have_key :uv
      expect(weather[:current][:uv]).to be_a Float
    end

    it "returns daily weather data for a location with it's lat/lng", :vcr do 
      weather = WeatherService.daily_forecast(38.10984, -87.78929)

    end

    it "returns hourly weather data for a location with it's lat/lng", :vcr do 
      weather = WeatherService.hourly_forecast(38.10984, -87.78929)

    end
  end
end