require 'rails_helper'

RSpec.describe MunchieFacade do 
  it 'returns a munchie object', :vcr do 
    location = 'Poseyville, IN'
    food = 'Pizza'

    munchie = MunchieFacade.munchie_search(location, food)

    expect(munchie).to be_a Munchie 
    expect(munchie.destination_city).to be_a String
    expect(munchie.forecast).to be_a Hash
    expect(munchie.forecast).to have_key :summary
    expect(munchie.forecast[:summary]).to be_a String 
    expect(munchie.forecast).to have_key :temperature
    expect(munchie.forecast[:temperature]).to be_a Float 
    expect(munchie.id).to eq nil
    expect(munchie.type).to be_a String 
    expect(munchie.type).to eq 'munchie'
    expect(munchie.restaurant).to be_an Array 
    expect(munchie.restaurant[0]).to have_key :name 
    expect(munchie.restaurant[0]).to have_key :address
    expect(munchie.restaurant[0]).to have_key :rating
    expect(munchie.restaurant[0]).to have_key :reviews

    result = munchie.restaurant[0]

    expect(result[:name]).to be_a String 
    expect(result[:address]).to be_a String 
    expect(result[:rating]).to be_a Float  
    expect(result[:reviews]).to be_an Integer 
  end 
end