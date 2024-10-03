# app/services/car_api_service.rb
require "httparty"

class CarApiService
  include HTTParty
  base_uri "https://car-api2.p.rapidapi.com"

  def initialize(api_key)
    @api_key = api_key
  end

  def fetch_all_makes
    self.class.get("/api/makes", headers: headers)
  end

  def fetch_models_for_make(make_id)
    self.class.get("/api/models/#{make_id}", headers: headers)
  end

  private

  def headers
    {
      "x-rapidapi-key" => @api_key,
      "x-rapidapi-host" => "car-api2.p.rapidapi.com",
      "Accept" => "application/json"
    }
  end
end
