require 'rails_helper'

RSpec.describe 'Forecast API' do
  describe 'Forecast request' do 
    it 'happy path- gets a forecast for a city', :vcr do 
      location = 'wadesville, in'

      get "/api/v0/forecast?location=#{location}"
      expect(response).to be_successful
      expect(response.status).to eq(200)
      
      forecast = JSON.parse(response.body, symbolize_names: true)

      expect(forecast).to be_a Hash
      expect(forecast).to have_key :data
      expect(forecast[:data]).to have_key :id 
      expect(forecast[:data][:id]).to eq(nil)
      expect(forecast[:data]).to have_key :type 
      expect(forecast[:data][:type]).to eq('forecast')
      expect(forecast[:data]).to have_key :attributes 

      expect(forecast[:data][:attributes]).to be_a Hash 
      expect(forecast[:data][:attributes]).to have_key :current_forecast
      expect(forecast[:data][:attributes][:current_forecast]).to be_a Hash
      expect(forecast[:data][:attributes]).to have_key :daily_forecast
      expect(forecast[:data][:attributes][:daily_forecast]).to be_an Array
      expect(forecast[:data][:attributes][:daily_forecast].count).to eq(5)
      expect(forecast[:data][:attributes]).to have_key :hourly_forecast
      expect(forecast[:data][:attributes][:hourly_forecast]).to be_an Array
      expect(forecast[:data][:attributes][:hourly_forecast].count).to eq(24)
    end

    it 'sad path- returns an error for no location given', :vcr do 
      location = ''
      get "/api/v0/forecast?location=#{location}"
      
      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      error_response = JSON.parse(response.body, symbolize_names: true)

      expect(error_response).to be_a Hash
      expect(error_response).to have_key :error
      expect(error_response[:error]).to be_a String
      expect(error_response[:error]).to eq('Location must be provided')
    end
  end
end