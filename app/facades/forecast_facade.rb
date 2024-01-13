class ForecastFacade 
  def self.get_forecast(location)
    lat_lon = MapQuestService.coordinates(location)
    lat = [:results][0][:locations][0][:latLng][:lat]
    lng = [:results][0][:locations][0][:latLng][:lng]

    current = WeatherService.current_forecast(lat, lng)
    cf = {
      last_updated: current.dig(:current, :last_updated),
      temperature: current.dig(:current, :temp_f),
      feels_like: current.dig(:current, :feelslike_f),
      humidity: current.dig(:current, :humidity),
      uvi: current.dig(:current, :uv),
      visibility: current.dig(:current, :vis_miles),
      condition: current.dig(:current, :condition, :text),
      icon: current.dig(:current, :condition, :icon)
    }

    daily = WeatherService.daily_forecast(lat, lng)
    df = daily[:forecast][:forecastday].map do |day|
      {
        date: day[:date],
        sunrise: day.dig(:astro, :sunrise),
        sunset: day.dig(:astro, :sunset),
        maxtemp: day.dig(:day, :maxtemp_f),
        mintemp: day.dig(:day, :mintemp_f),
        condition: day.dig(:day, :condition, :text),
        icon: day.dig(:day, :condition, :icon)
      }

      hourly = WeatherService.hourly_forecast(lat, lng)
      hf = hourly[:forecast][:forecastday][0][:hour].map do |hour|
        {
          time: hour[:time].split[1],
          temperature: hour[:temp_f],
          condition: hour[:condition][:text],
          icon: hour[:condition][:icon]
        }

        Forcast.new(cf, df, hf) 
      end
    end
  end
end