class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true 
  validates :api_key, presence: true, uniqueness: true 
  validates :password, presence: true

  has_secure_password 

  def generate_api_key
    self.api_key = SecureRandom.hex 
    # SecureRandom is safer (148 bits) than Random (48 bits)
  end
end