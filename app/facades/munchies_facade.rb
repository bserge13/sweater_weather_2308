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
    munchie_data = results[:businesses].map do |restaurant|
      { 
        name: restaurant[:name],
        address: restaurant[:location][:display_address][0],
        rating: restaurant[:rating],
        reviews: restaurant[:review_count]
      }
    end

    Munchie.new(destination, forecast, munchie_data)
  end
end