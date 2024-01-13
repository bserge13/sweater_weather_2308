class Forecast 
  attr_reader :id,
              :type,
              :current_forecast,
              :daily_forecast,
              :hourly_forecast 
  
  def initialize(cf, df, hf)
    @id = nil 
    @type = 'forecast'
    @current_forecast = cf 
    @daily_forecast = df 
    @hourly_forecast = hf 
  end
end