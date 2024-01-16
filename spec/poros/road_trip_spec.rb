require 'rails_helper'

RSpec.describe RoadTrip do 
  describe 'initialization' do 
    it 'exists with attributes' do 
      origin = 'evansville, in'
      destination = 'nashville, tn'
      travel_time = '02:10:06'
      arrival_forecast = {
        datetime: '2024-01-16 17:34',
        temperature: 14.0,
        condition: 'Overcast'
      }

      trip = RoadTrip.new(origin, destination, travel_time, arrival_forecast)

      expect(trip).to be_a RoadTrip
      expect(trip.id).to eq nil
      expect(trip.type).to eq 'roadtrip'
      expect(trip.start_city).to be_a String
      expect(trip.start_city).to eq origin
      expect(trip.end_city).to be_a String
      expect(trip.end_city).to eq destination
      expect(trip.travel_time).to be_a String 
      expect(trip.travel_time).to eq travel_time
      expect(trip.weather_at_eta).to be_a Hash 
      expect(trip.weather_at_eta).to have_key :datetime
      expect(trip.weather_at_eta[:datetime]).to be_a String
      expect(trip.weather_at_eta).to have_key :temperature
      expect(trip.weather_at_eta[:temperature]).to be_a Float
      expect(trip.weather_at_eta).to have_key :condition
      expect(trip.weather_at_eta[:condition]).to be_a String 
    end
  end 
end