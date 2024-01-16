require 'rails_helper'

RSpec.describe User do 
  describe 'validations' do 
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
    it { should validate_presence_of :api_key }
    it { should have_secure_password }
    it { should validate_uniqueness_of :email }
    it { should validate_uniqueness_of :api_key }
  end

  describe 'instance method' do 
    it 'generates a unique api_key for a user' do 
      kam = User.new(email: 'blake_rocks@turing.edu', password: 'seefood123', password_confirmation: 'seefood123')
      kam.generate_api_key

      expect(kam.api_key).to_not eq nil
      expect(kam.api_key).to be_a String 
    end
  end
end