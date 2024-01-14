class MunchiesSerializer
  include JSONAPI::Serializer 
  attributes :destination_city, :restaurant, :forecast
end