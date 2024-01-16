require 'rails_helper'

RSpec.describe 'Post request- road trip' do 
  before :each do 
    @db_user = User.create!(email: 'winchester1@gmail.com', password: 'Password', password_confirmation: 'Password', api_key: 'abcdefgh')
  end

  describe 'happy path' do
    it 'creates a new road trip' do 
      payload = {
        origin: 'new york, ny',
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
      require 'pry'; binding.pry
    end
  end
end