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

  describe '#trip_directions' do 
    it 'returns trip information weather coordinates for destination', :vcr do 
      trip = MapQuestService.trip_directions('evansville, in', 'nashville, tn')

      expect(trip).to be_a Hash 
      expect(trip[:route]).to be_a Hash

      route = trip[:route]

      expect(route).to have_key :formattedTime
      expect(route[:formattedTime]).to be_a String 
      expect(route).to have_key :locations
      expect(route[:locations]).to be_an Array 
      expect(route[:locations][0]).to be_a Hash
      expect(route[:locations][0]).to have_key :adminArea5
      expect(route[:locations][0][:adminArea5]).to eq 'Evansville'
      expect(route[:locations][1][:adminArea5]).to eq 'Nashville'
      expect(route[:locations][1]).to have_key :latLng
      expect(route[:locations][1][:latLng]).to be_a Hash 
      expect(route[:locations][1][:latLng]).to have_key :lat
      expect(route[:locations][1][:latLng][:lat]).to be_a Float 
      expect(route[:locations][1][:latLng]).to have_key :lng
      expect(route[:locations][1][:latLng][:lng]).to be_a Float 
    end
  end
end