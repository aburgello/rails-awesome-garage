# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Owner.destroy_all
Review.destroy_all
Favourite.destroy_all
Car.destroy_all

owner1 = Owner.create(nickname: 'Ben')
owner2 = Owner.create(nickname: 'Luke')
owner3 = Owner.create(nickname: 'Jonathan')
owner4 = Owner.create(nickname: 'Ted')
owner5 = Owner.create(nickname: 'Tom')


Car.create([
  {
    brand: 'Toyota',
    model: 'Camry',
    year: 2022,
    fuel: 'Gasoline',
    owner_id: owner1.id, # Replace with an actual owner ID
    image_url: 'https://www.topgear.com/sites/default/files/cars-car/image/2019/04/toyota-camry-hybrid-exterior-dynamic-not-uk-spec-26.jpg'
  },
  {
    brand: 'Honda',
    model: 'Civic',
    year: 2021,
    fuel: 'Gasoline',
    owner_id: owner2.id, # Replace with an actual owner ID
    image_url: 'https://images.prismic.io/carwow/ZpVHWx5LeNNTxKjo_2023HondaCivicfrontquarterdynamic.png?auto=format&cs=tinysrgb&fit=crop&q=60&w=750'
  },
  {
    brand: 'Ford',
    model: 'Mustang',
    year: 2020,
    fuel: 'Gasoline',
    owner_id: owner3.id, # Replace with an actual owner ID
    image_url: 'https://cdn.dlron.us/static/dealer-14949/2020-Ford-Mustang.jpg'
  },
  {
    brand: 'Lamborghini',
    model: 'Aventador',
    year: 2020,
    fuel: 'Gasoline',
    owner_id: owner4.id, # Replace with an actual owner ID
    image_url: 'https://www.motortrend.com/uploads/sites/5/2020/02/2020-Lamborghini-Aventador-SVJ-Roadster-45.jpg?w=768&width=768&q=75&format=webp'
  },
  {
    brand: 'Ferrari',
    model: 'SF-90 Stradale',
    year: 2024,
    fuel: 'Gasoline',
    owner_id: owner5.id, # Replace with an actual owner ID
    image_url: 'https://m.atcdn.co.uk/vms/media/3c4910ae62874128bc9923224a802544.jpg'
  }
])

puts "Seeded #{Car.count} cars."

Review.create(comment: 'Love this car!', rating: 5, car_id: 2)
Review.create(comment: 'It was OK...', rating: 3, car_id: 2)

Favourite.create(car_id: 1)
Favourite.create(car_id: 2)
