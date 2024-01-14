require 'rails_helper'

RSpec.describe Munchie do 
  it 'exists with attributes' do 
    destination = "Evansville, IN"
    forecast = { :summary=>'Colder than should be allowed', :temperature=>8.1 } 
    munchie_data = [{ :name=>"P J's Pizza", :address=>"10463 Whiting St", :rating=>4.5, :reviews=>2},
    {:name=>"Susan Bobe's Pizza", :address=>"101 W Broadway St", :rating=>4.0, :reviews=>16 }]
    munchie = Munchie.new(destination, forecast, munchie_data)

    expect(munchie).to be_a Munchie 
    expect(munchie.destination_city).to be_a String
    expect(munchie.destination_city).to eq 'Evansville, IN'
    expect(munchie.forecast).to be_a Hash
    expect(munchie.forecast).to have_key :summary
    expect(munchie.forecast[:summary]).to be_a String
    expect(munchie.forecast).to have_key :temperature
    expect(munchie.forecast[:temperature]).to be_a Float 
    expect(munchie.id).to eq nil 
    expect(munchie.type).to eq 'munchie'
    expect(munchie.restaurant).to be_an Array 
    
    result = munchie.restaurant[0]

    expect(result).to have_key :name
    expect(result[:name]).to be_a String 
    expect(result).to have_key :address
    expect(result[:address]).to be_a String 
    expect(result).to have_key :rating
    expect(result[:rating]).to be_a Float 
    expect(result).to have_key :reviews
    expect(result[:reviews]).to be_an Integer 
  end
end