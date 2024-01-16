class RoadTripFacade
  def self.get_road_trip(origin, destination)
    directions = MapQuestService.trip_directions(origin, destination)
    if directions[:route].has_key?(:routeError)
      RoadTrip.new(origin, destination, 'impossible route', {})
    else 
      destination_lat = directions[:route][:locations][1][:latLng][:lat]  
      destination_lng = directions[:route][:locations][1][:latLng][:lng] 

      travel_time = directions[:route][:realTime]
      arrival_time = Time.now + travel_time
      formatted_arrival = arrival_time.strftime('%Y-%m-%d %H:%M')
      formatted_travel = directions[:route][:formattedTime]

      forecast = WeatherService.daily_forecast(destination_lat, destination_lng)
      forecast[:forecast][:forecastday].map do |day|
        next unless arrival_time.to_s.include?(day[:date])
        @arrival_forecast = {
          datetime: formatted_arrival,
          temperature: day[:hour][arrival_time.hour][:temp_f],
          condition: day[:hour][arrival_time.hour][:condition][:text]
        }
      end
      RoadTrip.new(origin, destination, formatted_travel, @arrival_forecast)
    end
  end
end