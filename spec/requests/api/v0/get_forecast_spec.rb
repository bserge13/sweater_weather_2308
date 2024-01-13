require 'rails_helper'

RSpec.describe 'Forecast API' do
  describe 'Forecast request' do 
    it 'happy path- gets a forecast for a caity', :vcr do 
      location = 'wadesville, in'

      get "/api/v0/forecast?location=#{location}"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      forecast = JSON.parse(response.body, sumbolize_names: true)

      expect(forecast).to be_a Hash
      expect(forecast).to have_key :data
    end
  end
end