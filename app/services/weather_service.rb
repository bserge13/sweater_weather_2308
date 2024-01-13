class WeatherService 
  def self.current_forecast(lat, lng)
    get_url("/v1/current.json?q=#{lat},#{lng}")
  end
  
  def self.daily_forecast(lat, lng)
    get_url("/v1/forecast.json?q=#{lat},#{lng}&days=5")
  end
  
  def self.hourly_forecast(lat, lng)
    get_url("/v1/forecast.json?q=#{lat},#{lng}")
  end
  
  private 

  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn 
    Faraday.new(url: 'http://api.weatherapi.com') do |f|
      f.params['key'] = Rails.application.credentials.weather[:WEATHER_API_KEY]
    end
  end
end