require 'rails_helper'

RSpec.describe 'Munchie API' do 
  describe 'Munchies search request' do 
    it 'returns suggested places to eat based off category and location', :vcr do 
      location = 'henderson, ky'
      food = 'italian' 

      get "/api/v1/munchies?destination=#{location}&food=#{food}"
      expect(response).to be_successful
      expect(response.status).to eq(200)

      results = JSON.parse(response.body, symbolize_names: true)

      expect(results).to be_a Hash 
    end
  end
end