class MunchiesFacade 
  def self.munchie_search(location, food)
    coordinates = MapQuestService.coordinates(location)
    lat = coordinates[:results][0][:locations][0][:latLng][:lat]
    lng = coordinates[:results][0][:locations][0][:latLng][:lng] 

    weather = WeatherService.current_forecast(lat,lng)
    forecast = {
      summary: weather[:current][:condition][:text],
      temperature: weather[:current][:temp_f]
    }

    food = MunchiesService.find_food(location, food) 
  end
end