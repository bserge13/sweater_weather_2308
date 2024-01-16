require 'rails_helper'

RSpec.describe ForecastFacade do 
  it 'retrieves roadtrip details', :vcr do 
    trip = RoadTripFacade.get_road_trip('new york city, ny', 'los angeles, ca')

    expect(trip).to be_a RoadTrip
    expect(trip.id).to eq nil
    expect(trip.type).to eq 'roadtrip'
    expect(trip.start_city).to eq 'new york city, ny'
    expect(trip.end_city).to eq 'los angeles, ca'
    expect(trip.travel_time).to be_a String 
    expect(trip.weather_at_eta).to be_a Hash
    expect(trip.weather_at_eta).to have_key :datetime
    expect(trip.weather_at_eta[:datetime]).to be_a String   
    expect(trip.weather_at_eta).to have_key :temperature
    expect(trip.weather_at_eta[:temperature]).to be_a Float
    expect(trip.weather_at_eta).to have_key :condition
    expect(trip.weather_at_eta[:condition]).to be_a String
  end

  it 'creates an impossible route response', :vcr do 
    trip = RoadTripFacade.get_road_trip('new york city, ny', 'london, uk')

    expect(trip).to be_a RoadTrip
    expect(trip.id).to eq nil
    expect(trip.type).to eq 'roadtrip'
    expect(trip.start_city).to eq 'new york city, ny'
    expect(trip.end_city).to eq 'london, uk'
    expect(trip.travel_time).to eq 'impossible route'
    expect(trip.weather_at_eta).to eq ({})
  end
end 