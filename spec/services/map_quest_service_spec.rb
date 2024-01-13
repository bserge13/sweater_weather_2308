require 'rails_helper'

RSpec.describe MapQuestService do 
  describe 'Coordinates' do 
    it 'gets the lat/lng for a given city and state', :vcr do 
      coordinates = MapQuestService.coordinates('nashville, tn')
      
      expect(coordinates).to be_a Hash 
      expect(coordinates[:results][0][:locations][0][:latLng]).to be_a Hash
      expect(coordinates[:results][0][:locations][0][:latLng]).to have_key :lat
      expect(coordinates[:results][0][:locations][0][:latLng][:lat]).to be_a Float
      expect(coordinates[:results][0][:locations][0][:latLng]).to have_key :lng 
      expect(coordinates[:results][0][:locations][0][:latLng][:lat]).to be_a Float 
    end
  end
end