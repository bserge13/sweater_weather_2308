class ForecastSerializer
  include JSONAPI::Serializer 
  attributes :current_forecast, :daily_forecast, :hourly_forecast 
end