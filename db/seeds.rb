# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

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
    owner_id: owner1.id,
    image_url: 'https://www.topgear.com/sites/default/files/cars-car/image/2019/04/toyota-camry-hybrid-exterior-dynamic-not-uk-spec-26.jpg'
  },
  {
    brand: 'Honda',
    model: 'Civic',
    year: 2021,
    fuel: 'Gasoline',
    owner_id: owner2.id,
    image_url: 'https://images.prismic.io/carwow/ZpVHWx5LeNNTxKjo_2023HondaCivicfrontquarterdynamic.png?auto=format&cs=tinysrgb&fit=crop&q=60&w=750'
  },
  {
    brand: 'Ford',
    model: 'Mustang',
    year: 2020,
    fuel: 'Gasoline',
    owner_id: owner3.id,
    image_url: 'https://cdn.dlron.us/static/dealer-14949/2020-Ford-Mustang.jpg'
  },
  {
    brand: 'Lamborghini',
    model: 'Aventador',
    year: 2020,
    fuel: 'Gasoline',
    owner_id: owner4.id,
    image_url: 'https://www.motortrend.com/uploads/sites/5/2020/02/2020-Lamborghini-Aventador-SVJ-Roadster-45.jpg?w=768&width=768&q=75&format=webp'
  },
  {
    brand: 'Ferrari',
    model: 'SF-90 Stradale',
    year: 2024,
    fuel: 'Gasoline',
    owner_id: owner5.id,
    image_url: 'https://m.atcdn.co.uk/vms/media/3c4910ae62874128bc9923224a802544.jpg'
  },
  {
    brand: 'Chevrolet',
    model: 'Corvette',
    year: 2022,
    fuel: 'Gasoline',
    owner_id: owner1.id,
    image_url: 'https://images.pistonheads.com/nimg/47748/mceu_57726184811697203735390.jpg'
  },
  {
    brand: 'Tesla',
    model: 'Model S',
    year: 2023,
    fuel: 'Electric',
    owner_id: owner2.id,
    image_url: 'https://media.autoexpress.co.uk/image/private/s--X-WVjvBW--/f_auto,t_content-image-full-desktop@1/v1689934611/autoexpress/2023/07/Tesla%20Model%20S%20Plaid%20001_yujihf.jpg'
  },
  {
    brand: 'BMW',
    model: 'M3',
    year: 2021,
    fuel: 'Gasoline',
    owner_id: owner3.id,
    image_url: 'https://images.prismic.io/carwow/da024fea-3ccd-4e9a-99d2-aad65bcec58b_2021+BMW+M3+front+quarter+moving+2.jpg'
  },
  {
    brand: 'Porsche',
    model: '911',
    year: 2022,
    fuel: 'Gasoline',
    owner_id: owner4.id,
    image_url: 'https://newsroom.porsche.com/.imaging/mte/porsche-templating-theme/image_1290x726/dam/pnr/2024/Products/992-II/0840_nevada_coupe_u-crane_AKOS0607_edit_V03-sky.jpg/jcr:content/0840_nevada_coupe_u-crane_AKOS0607_edit_V03-sky.jpg'
  },
  {
    brand: 'Audi',
    model: 'R8',
    year: 2021,
    fuel: 'Gasoline',
    owner_id: owner5.id,
    image_url: 'https://uploads.audi-mediacenter.com/system/production/media/70272/images/3c92d2acbf6ab5f85be8006f854786f0f0ff36be/A1813681_web_2880.jpg?1698341967'
  },
  {
    brand: 'Nissan',
    model: 'GTR',
    year: 2020,
    fuel: 'Gasoline',
    owner_id: owner1.id,
    image_url: 'https://www.stratstone.com/-/media/stratstone/spotlight/nissan-gt-r-nismo/carousel/nissan-gtr-exterior-driving-1280x516px.ashx'
  },
  {
    brand: 'Mazda',
    model: 'MX-5 Miata',
    year: 2021,
    fuel: 'Gasoline',
    owner_id: owner2.id,
    image_url: 'https://images.pistonheads.com/nimg/48354/blobid0.jpg'
  },
  {
    brand: 'Subaru',
    model: 'WRX',
    year: 2022,
    fuel: 'Gasoline',
    owner_id: owner3.id,
    image_url: 'https://www.topgear.com/sites/default/files/cars-car/image/2015/02/buyers_guide_-_subaru_wrx_sti_2014_-_front_quarter_0.jpg'
  },
  {
    brand: 'Mercedes-Benz',
    model: 'C-Class',
    year: 2021,
    fuel: 'Gasoline',
    owner_id: owner4.id,
    image_url: 'https://www.topgear.com/sites/default/files/2021/11/Mercedes_C300D_0000.jpg'
  },
  {
    brand: 'Hyundai',
    model: 'Elantra',
    year: 2022,
    fuel: 'Gasoline',
    owner_id: owner5.id,
    image_url: 'https://hips.hearstapps.com/hmg-prod/images/2024-hyundai-elantra-limited-106-64ef85e2044f5.jpg?crop=0.661xw:0.496xh;0.197xw,0.381xh&resize=1200:*'
  },
  {
    brand: 'Kia',
    model: 'Stinger',
    year: 2023,
    fuel: 'Gasoline',
    owner_id: owner1.id,
    image_url: 'https://assets.whichcar.com.au/image/private/s--BBcgtNa---/c_fill,f_auto,g_xy_center,q_auto:good,x_2736,y_1824/t_p_16x9/v1/Motor/Reviews/Kia_Stinger_GT_LTT5_front_quarter_static.jpg'
  },
  {
    brand: 'Volkswagen',
    model: 'GTI',
    year: 2022,
    fuel: 'Gasoline',
    owner_id: owner2.id,
    image_url: 'https://images.prismic.io/carwow/ZrD5EkaF0TcGIsRd_2024VWGolfGTIfrontquarterstatic.jpg'
  },
  {
    brand: 'Chrysler',
    model: '300',
    year: 2021,
    fuel: 'Gasoline',
    owner_id: owner3.id,
    image_url: 'https://autoimage.capitalone.com/cms/Auto/assets/images/2868-hero-2023-chrysler-300c-red-front-quarter-left.jpg'
  },
  {
    brand: 'Jaguar',
    model: 'F-Type',
    year: 2022,
    fuel: 'Gasoline',
    owner_id: owner4.id,
    image_url: 'https://www.carkeys.co.uk/media/20175/jaguar-f-type-r-awd-coupe.jpg?anchor=center&mode=crop&width=1200&height=800'
  },
  {
    brand: 'Volvo',
    model: 'S60',
    year: 2023,
    fuel: 'Gasoline',
    owner_id: owner5.id,
    image_url: 'https://www.autocar.co.uk/sites/autocar.co.uk/files/1-volvo-s60-polestar-engineered-2020-rt-hero-front.jpg'
  }
])

puts "Seeded #{Car.count} cars."

Review.create(comment: 'Love this car!', rating: 5, car_id: 2)
Review.create(comment: 'It was OK...', rating: 3, car_id: 2)

Favourite.create(car_id: 1)
Favourite.create(car_id: 2)
