class Munchie 
  attr_reader :id,
              :type,
              :destination_city,
              :forecast,
              :restaurant 

  def initialize(location, forecast, munchie_data) 
    @id = nil 
    @type = 'munchie'
    @destination_city = location
    @forecast = forecast
    @restaurant = munchie_data
  end
end