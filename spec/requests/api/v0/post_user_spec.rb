require 'rails_helper'

RSpec.describe 'Users POST request' do 
  describe 'happy path' do 
    it 'creates a new user' do 
      params = {
        email: 'the_dude@aol.com',
        password: 'password123',
        password_confirmation: 'password123'
      }

      header = {
        'CONTENT_TYPE' => 'application/json',
        'ACCEPT' => 'application/json'
      }

      post '/api/v0/users', headers: header, params: params, as: :json

      expect(response).to be_successful 
      expect(response.status).to eq 201

      user = JSON.parse(response.body, symbolize_names: true)

      expect(user).to be_a Hash 
      expect(user).to have_key :data 
      expect(user[:data]).to have_key :id
      expect(user[:data]).to have_key :type
      expect(user[:data][:type]).to eq 'user'
      expect(user[:data]).to have_key :attributes
      expect(user[:data][:attributes]).to have_key :email
      expect(user[:data][:attributes][:email]).to be_a String
      expect(user[:data][:attributes]).to have_key :api_key
      expect(user[:data][:attributes][:api_key]).to be_a String 
    end
  end

  describe 'sad path' do
    it 'cannot create a user with an email already in use' do 
      User.create!(
        email: 'winchester1@gmail.com', 
        password: 'abc123',
        password_confirmation: 'abc123',
        api_key: 'abcdefg'
      )

      payload = {
        email: 'winchester1@gmail.com',
        password: 'Password',
        password_confirmation: 'Password'
      }

      header = {
        'CONTENT_TYPE' => 'application/json',
        'ACCEPT' => 'application/json'
      }

      post '/api/v0/users', headers: header, params: payload, as: :json

      expect(response).to_not be_successful 
      expect(response.status).to eq 400

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a Hash
      expect(error).to have_key :errors
      expect(error[:errors]).to eq 'Email has already been taken'
    end

    it 'connot create a user without password & confirmation matching' do 
      payload = {
        email: 'winchester1@gmail.com',
        password: 'Password',
        password_confirmation: 'Password!'
      }

      header = {
        'CONTENT_TYPE' => 'application/json',
        'ACCEPT' => 'application/json'
      }

      post '/api/v0/users', headers: header, params: payload, as: :json

      expect(response).to_not be_successful 
      expect(response.status).to eq 400

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a Hash
      expect(error).to have_key :errors
      expect(error[:errors]).to eq "Password confirmation doesn't match Password"
    end

    it 'cannot create a user without an email' do 
      payload = {
        email: '',
        password: 'Password',
        password_confirmation: 'Password'
      }

      header = {
        'CONTENT_TYPE' => 'application/json',
        'ACCEPT' => 'application/json'
      }

      post '/api/v0/users', headers: header, params: payload, as: :json

      expect(response).to_not be_successful 
      expect(response.status).to eq 400

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a Hash
      expect(error).to have_key :errors
      expect(error[:errors]).to eq "Email can't be blank"
    end
  end
end