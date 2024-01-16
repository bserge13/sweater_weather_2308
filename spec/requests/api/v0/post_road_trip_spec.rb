require 'rails_helper'

RSpec.describe 'Post request- road trip' do 
  before :each do 
    @db_user = User.create!(email: 'winchester1@gmail.com', password: 'Password', password_confirmation: 'Password', api_key: 'abcdefgh')
  end

  describe 'happy path' do
    it 'creates a new road trip', :vcr do 
      payload = {
        origin: 'new york city, ny',
        destination: 'los angeles, ca',
        api_key: @db_user.api_key
      }

      header = {
        'CONTENT_TYPE' => 'application/json',
        'ACCEPT' => 'application/json'
      }

      post '/api/v0/road_trip', headers: header, params: payload, as: :json

      expect(response).to be_successful 
      expect(response.status).to eq 201 

      trip = JSON.parse(response.body, symbolize_names: true)

      expect(trip).to be_a Hash 
      expect(trip).to have_key :data 
      expect(trip[:data]).to have_key :id
      expect(trip[:data][:id]).to eq nil
      expect(trip[:data]).to have_key :type
      expect(trip[:data][:type]).to be_a String 
      expect(trip[:data][:type]).to eq 'road_trip'
      expect(trip[:data]).to have_key :attributes 
      expect(trip[:data][:attributes]).to be_a Hash 

      trip_attrs = trip[:data][:attributes]
      expect(trip_attrs).to be_a Hash
      expect(trip_attrs).to have_key :start_city
      expect(trip_attrs[:start_city]).to be_a String
      expect(trip_attrs).to have_key :end_city
      expect(trip_attrs[:end_city]).to be_a String
      expect(trip_attrs).to have_key :travel_time
      expect(trip_attrs[:travel_time]).to be_a String

      weather = trip_attrs[:weather_at_eta]
      expect(weather).to be_a Hash
      expect(weather).to have_key :datetime
      expect(weather[:datetime]).to be_a String 
      expect(weather).to have_key :temperature
      expect(weather[:temperature]).to be_a Float 
      expect(weather).to have_key :condition
      expect(weather[:condition]).to be_a String 
    end

    it 'creates a response for impossible routes', :vcr do 
      payload = {
        origin: 'new york, ny',
        destination: 'london, uk',
        api_key: @db_user.api_key
      }

      header = {
        'CONTENT_TYPE' => 'application/json',
        'ACCEPT' => 'application/json'
      }

      post '/api/v0/road_trip', headers: header, params: payload, as: :json

      expect(response).to be_successful 
      expect(response.status).to eq 201 

      trip = JSON.parse(response.body, symbolize_names: true)

      expect(trip).to be_a Hash
      expect(trip).to have_key :data
      expect(trip[:data]).to be_a Hash
      expect(trip[:data]).to have_key :id
      expect(trip[:data][:id]).to eq nil
      expect(trip[:data]).to have_key :type
      expect(trip[:data][:type]).to be_a String
      expect(trip[:data][:type]).to eq 'road_trip'
      expect(trip[:data]).to have_key :attributes
      expect(trip[:data][:attributes]).to be_a Hash

      data = trip[:data][:attributes]

      expect(data).to have_key :start_city
      expect(data[:start_city]).to be_a String      
      expect(data).to have_key :end_city
      expect(data[:end_city]).to be_a String      
      expect(data).to have_key :travel_time
      expect(data[:travel_time]).to be_a String  
      expect(data[:travel_time]).to eq 'impossible route'
      expect(data).to have_key :weather_at_eta
      expect(data[:weather_at_eta]).to be_a Hash      
    end 
  end

  describe 'sad path' do
    it 'generates an error for a wrong API key use', :vcr do 
      payload = {
        origin: 'new york, ny',
        destination: 'los angeles, ca',
        api_key: 'abcIFORGOTTHEREST'
      }

      header = {
        'CONTENT_TYPE' => 'application/json',
        'ACCEPT' => 'application/json'
      }

      post '/api/v0/road_trip', headers: header, params: payload, as: :json

      expect(response).to_not be_successful 
      expect(response.status).to eq 401

      errors = JSON.parse(response.body, symbolize_names: true)

      expect(errors).to be_a Hash
      expect(errors).to have_key :error
      expect(errors[:error]).to be_a String
      expect(errors[:error]).to eq 'Invalid API Key'
    end 

    it 'generates an error for no API key use', :vcr do 
      payload = {
        origin: 'new york, ny',
        destination: 'los angeles, ca',
        api_key: nil
      }

      header = {
        'CONTENT_TYPE' => 'application/json',
        'ACCEPT' => 'application/json'
      }

      post '/api/v0/road_trip', headers: header, params: payload, as: :json

      expect(response).to_not be_successful 
      expect(response.status).to eq 401

      errors = JSON.parse(response.body, symbolize_names: true)

      expect(errors).to be_a Hash
      expect(errors).to have_key :error
      expect(errors[:error]).to be_a String
      expect(errors[:error]).to eq 'Invalid API Key'

    end 
  end 
end