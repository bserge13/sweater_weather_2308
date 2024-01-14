require 'rails_helper'

RSpec.describe 'Munchie API' do 
  describe 'Munchies search request' do 
    it 'returns suggested places to eat based off category and location', :vcr do 
      location = 'Evansville, IN'
      food = 'Italian' 

      get "/api/v1/munchies?destination=#{location}&food=#{food}"
      expect(response).to be_successful
      expect(response.status).to eq(200)

      results = JSON.parse(response.body, symbolize_names: true)

      expect(results).to be_a Hash 
      expect(results[:data]).to have_key :id
      expect(results[:data][:id]).to eq nil 
      expect(results[:data]).to have_key :type
      expect(results[:data][:type]).to eq 'munchie' 
      expect(results[:data]).to have_key :attributes 
      expect(results[:data][:attributes]).to be_a Hash 

      yelp = results[:data][:attributes]
      
      expect(yelp).to have_key :destination_city
      expect(yelp[:destination_city]).to be_a String 
      expect(yelp[:destination_city]).to eq("Evansville, IN")
      expect(yelp).to have_key :forecast
      expect(yelp[:forecast]).to be_a Hash 
      expect(yelp).to have_key :restaurant
      expect(yelp[:restaurant]).to be_an Array 

      food = yelp[:restaurant][0]

      expect(food).to be_a Hash
      expect(food).to have_key :name
      expect(food[:name]).to be_a String
      expect(food).to have_key :address
      expect(food[:address]).to be_a String
      expect(food).to have_key :rating
      expect(food[:rating]).to be_a Float
      expect(food).to have_key :reviews
      expect(food[:reviews]).to be_an Integer
    end
  end
end