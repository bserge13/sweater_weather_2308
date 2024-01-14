require 'rails_helper'

RSpec.describe MunchieService do 
  it 'returns the results of a munchie search', :vcr do 
    location = 'Santa Rita, Guam'
    food = 'mexican'
    munchie = MunchieService.find_food(location, food)

    expect(munchie).to be_a Hash
    expect(munchie[:businesses]).to be_an Array 

    results = munchie[:businesses][0]

    expect(results).to be_a Hash 
    expect(results).to have_key :name 
    expect(results[:name]).to be_a String
    expect(results).to have_key :review_count
    expect(results[:review_count]).to be_an Integer
    expect(results).to have_key :rating 
    expect(results[:rating]).to be_a Float 
  end
end