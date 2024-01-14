class MunchiesService 
  def self.find_food(destination, food)
    get_url("/v3/businesses/search?location=#{destination}&term=#{food}")
  end 

  private

  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn 
    Faraday.new(url: 'https://api.yelp.com') do |f|
      f.headers['Authorization'] = Rails.application.credentials.yelp[:YELP_API_KEY]
    end
  end
end