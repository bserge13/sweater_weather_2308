require 'rails_helper'

RSpec.describe 'Post request- sessions' do 
  before :each do 
    @db_user = User.create!(email: 'winchester1@gmail.com', password: 'Password', password_confirmation: 'Password', api_key: 'abcdefgh')
  end

  describe 'happy path' do 
    it 'creates a new session' do 
      payload = {
        email: 'winchester1@gmail.com',
        password: 'Password',
      }

      header = {
        'CONTENT_TYPE' => 'application/json',
        'ACCEPT' => 'application/json'
      }

      post '/api/v0/sessions', headers: header, params: payload, as: :json

      expect(response).to be_successful 

      session = JSON.parse(response.body, symbolize_names: true)

      expect(session).to be_a Hash 
      expect(session).to have_key :data 
      expect(session[:data]).to be_a Hash 
      expect(session[:data]).to have_key :id
      expect(session[:data]).to have_key :type
      expect(session[:data][:type]).to eq 'user'
      expect(session[:data]).to have_key :attributes
      expect(session[:data][:attributes]).to be_a Hash 
      expect(session[:data][:attributes]).to have_key :email
      expect(session[:data][:attributes][:email]).to be_a String 
      expect(session[:data][:attributes][:email]).to eq(@db_user.email)
      expect(session[:data][:attributes]).to have_key :api_key
      expect(session[:data][:attributes][:api_key]).to be_a String 
      expect(session[:data][:attributes][:api_key]).to eq(@db_user.api_key)
    end
  end
end