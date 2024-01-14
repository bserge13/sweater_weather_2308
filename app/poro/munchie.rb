class Munchie 
  attr_reader :id,
              :type,
              :destination_city,
              :forecast,
              :restaurant 

  def initialize(destination, forecast, munchie_data) 
    @id = nil 
    @type = 'munchie'
    @destination_city = destination
    @forecast = forecast
    @restaurant = munchie_data
  end
end