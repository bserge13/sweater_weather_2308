class MunchiesFacade 
  def self.munchie_search(destination, food)
    coordinates = MapQuestService.coordinates(destination)
    lat = coordinates[:results][0][:locations][0][:latLng][:lat]
    lng = coordinates[:results][0][:locations][0][:latLng][:lng] 
    
    weather = WeatherService.current_forecast(lat,lng)
    forecast = {
      summary: weather[:current][:condition][:text],
      temperature: weather[:current][:temp_f]
    }
    
    results = MunchiesService.find_food(destination, food) 
    munchie_data = results.map do |restaurant|
      { 
        name: restaurant[:name],
        address: restaurant[:location][:display_address],
        rating: restaurant[:rating],
        reviews: restaurant[:review_count]
      }
    end

    Munchie.new(forecast, location, munchie_data)
  end
end