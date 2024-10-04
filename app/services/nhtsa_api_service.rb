# app/services/nhtsa_api_service.rb
class NhtsaApiService
  include HTTParty
  base_uri "https://vpic.nhtsa.dot.gov/api"

  def fetch_cars(make, model_year)
    self.class.get("/vehicles/getmodelsformakeyear/make/#{make}/modelyear/#{model_year}?format=json")
  end
end
