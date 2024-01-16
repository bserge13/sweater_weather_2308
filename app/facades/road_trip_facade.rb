class RoadTripFacade
  def slef.get_road_trip(origin, destination)
    directions = MapQuestService.trip_directions(origin, destination)
    if directions[:route].has_key?(:routeError)
      RoadTrip.new(origin, destination, 'impossible route', {})
    else 
      dest_lat = directions[:route][:locations][1][:latLng][:lat]  
      dest_lng = directions[:route][:locations][1][:latLng][:lng] 

      travel_time = directions[:route][:realTime]
      arrival_time = Time.now + travel_time
      formatted_arrival = arrival_time.strftime('%Y-%m-%d %H:%M')
      formatted_travel = directions[:route][:formattedTime]
    end
  end
end