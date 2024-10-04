# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


require_relative '../app/services/nhtsa_api_service'
require 'faker'


Review.destroy_all
Favourite.destroy_all
Car.destroy_all

image_urls = {
  'LAMBORGHINI' => [
    'https://www.motortrend.com/uploads/sites/5/2020/02/2020-Lamborghini-Aventador-SVJ-Roadster-45.jpg?w=768&width=768&q=75&format=webp'
  ],
  'FERRARI' => [
    'https://m.atcdn.co.uk/vms/media/3c4910ae62874128bc9923224a802544.jpg'
  ],
  'BMW' => [
    'https://images.prismic.io/carwow/da024fea-3ccd-4e9a-99d2-aad65bcec58b_2021+BMW+M3+front+quarter+moving+2.jpg'
  ],
  'PORSCHE' => [
    'https://newsroom.porsche.com/.imaging/mte/porsche-templating-theme/image_1290x726/dam/pnr/2024/Products/992-II/0840_nevada_coupe_u-crane_AKOS0607_edit_V03-sky.jpg/jcr:content/0840_nevada_coupe_u-crane_AKOS0607_edit_V03-sky.jpg'
  ],
  'MERCEDES-BENZ' => [
    'https://www.topgear.com/sites/default/files/2021/11/Mercedes_C300D_0000.jpg'
  ],
  'AUDI' => [
    'https://uploads.audi-mediacenter.com/system/production/media/70272/images/3c92d2acbf6ab5f85be8006f854786f0f0ff36be/A1813681_web_2880.jpg?1698341967'
  ]

}


owner_names = []
20.times do
  owner_names << Faker::Name.name
end

owners = owner_names.map do |name|
  Owner.find_or_create_by!(nickname: name)
end

service = NhtsaApiService.new

brands = [ 'porsche', 'lamborghini', 'ferrari', 'bmw', 'audi', 'mercedes' ]
years = (2016..2024).to_a
fuel_types = [ 'Gasoline', 'Diesel', 'Electric', 'Hybrid' ]

brands.each do |brand|
  cars_added = 0

  years.sample(3).each do |year|
    response = service.fetch_cars(brand, year)
    car_data_array = response.parsed_response['Results']

    if car_data_array.is_a?(Array)
      car_data_array.each do |car_data|
        break if cars_added >= 10

        brand_name = car_data['Make_Name']

        car_image_url = image_urls[brand_name]&.sample || 'https://via.placeholder.com/300x200'

        Car.create!(
          brand: brand_name,
          model: car_data['Model_Name'],
          year: year,
          fuel: fuel_types.sample,
          owner: owners.sample,
          image_url: car_image_url,
          vin: Faker::Vehicle.vin
        )

        cars_added += 1
      end
    end
  end
end




Car.create([
  {
    brand: 'LAMBORGHINI',
    model: 'Aventador',
    year: 2020,
    fuel: 'Gasoline',
    owner_id: owners.sample,
    image_url: 'https://www.motortrend.com/uploads/sites/5/2020/02/2020-Lamborghini-Aventador-SVJ-Roadster-45.jpg?w=768&width=768&q=75&format=webp'
  },
  {
    brand: 'FERRARI',
    model: 'SF-90 Stradale',
    year: 2024,
    fuel: 'Gasoline',
    owner_id: owners.sample,
    image_url: 'https://m.atcdn.co.uk/vms/media/3c4910ae62874128bc9923224a802544.jpg'
  },
  {
    brand: 'BMW',
    model: 'M3',
    year: 2021,
    fuel: 'Gasoline',
    owner_id: owners.sample,
    image_url: 'https://images.prismic.io/carwow/da024fea-3ccd-4e9a-99d2-aad65bcec58b_2021+BMW+M3+front+quarter+moving+2.jpg'
  },
  {
    brand: 'PORSCHE',
    model: '911',
    year: 2022,
    fuel: 'Gasoline',
    owner_id: owners.sample,
    image_url: 'https://newsroom.porsche.com/.imaging/mte/porsche-templating-theme/image_1290x726/dam/pnr/2024/Products/992-II/0840_nevada_coupe_u-crane_AKOS0607_edit_V03-sky.jpg/jcr:content/0840_nevada_coupe_u-crane_AKOS0607_edit_V03-sky.jpg'
  },
  {
    brand: 'MERCEDES-BENZ',
    model: 'C-Class',
    year: 2021,
    fuel: 'Gasoline',
    owner_id: owners.sample,
    image_url: 'https://www.topgear.com/sites/default/files/2021/11/Mercedes_C300D_0000.jpg'
  }
])

puts "Seeded #{Car.count} cars."
