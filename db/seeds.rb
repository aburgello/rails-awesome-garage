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
    'https://www.motortrend.com/uploads/sites/5/2020/02/2020-Lamborghini-Aventador-SVJ-Roadster-45.jpg?w=768&width=768&q=75&format=webp',
    'https://www.lamborghini.com/sites/it-en/files/DAM/lamborghini/facelift_2019/models_gw/2023/03_29_revuelto/gate_models_s_02_m.jpg',
    'https://www.lamborghini.com/sites/it-en/files/DAM/lamborghini/facelift_2019/models_gw/2024/08_16_temerario/over/temerario-mobile.jpg',
    'https://media.wired.com/photos/6580ba9fc9d019ec4391c2b9/191:100/w_1280,c_limit/Reuelto_Grigio%20Telesto_001.jpg',
    'https://storage.googleapis.com/pod_public/1300/176804.jpg',
    'https://i.ebayimg.com/images/g/nWoAAOSwvLteb0CV/s-l1200.jpg',
    'https://starrluxurycars.com/wp-content/uploads/2024/08/SLC-starr-luxury-cars-lamborghini-urus-big-ben-and-the-houses-of-parliament-buckingham-palace-tower-of-london-westminster-abbey-stonehenge-cambridge-edinburgh-castle-united-kingdom-self-drive.jpg',
    'https://media.gq-magazine.co.uk/photos/6160308c158cad41ab95aabc/master/pass/081021_huracan_HP.jpg',
    'https://carwow-uk-wp-0.imgix.net/New-Lamborghini-Temerario-lead.png?auto=format&cs=tinysrgb&fit=clip&ixlib=rb-1.1.0&q=10&w=460'
  ],
  'FERRARI' => [
    'https://m.atcdn.co.uk/vms/media/3c4910ae62874128bc9923224a802544.jpg',
    'https://cdn.ferrari.com/cms/network/media/img/resize/631b55bb9ba7b26ce62de2e7?',
    'https://robbreport.com/wp-content/uploads/2019/09/ferrari-812-gts_04.jpg?w=1000',
    'https://www.motortrend.com/uploads/sites/5/2021/05/2021-Ferrari-SF90.jpg',
    'https://www.funcars.biz/wp-content/uploads/2023/07/1684959048-ferrari-458-002.jpg',
    'https://storage.googleapis.com/pod_public/1300/166577.jpg',
    'https://cdn.ferrari.com/cms/network/media/img/resize/6093c24cef0edd50a7434d90-ferrari-magazine-buijPJtX-p.jpg?width=768&height=430',
    'https://www.acumenfinancial.co.uk/wp-content/uploads/2022/07/ezgif-4-e5a50355ca.jpeg',
    'https://upload.wikimedia.org/wikipedia/commons/c/c6/2011_Ferrari_458_Italia_DCT_S-A_4.5_Front.jpg',
    'https://sothebys-com.brightspotcdn.com/dims4/default/d0061b4/2147483647/strip/true/crop/1920x1440+0+0/resize/1067x800!/quality/90/?url=http%3A%2F%2Fsothebys-brightspot.s3.amazonaws.com%2Fdotcom%2F54%2Fd1%2F5f990e7c49c093367658d61cc0d5%2Fferrari-f40-1.jpg',
    'https://media.wired.com/photos/5ceeed5b0bdd96c34c6174a3/16:9/w_2400,h_1350,c_limit/01_Ferrari_SF90_03.jpg'
  ],
  'BMW' => [
    'https://images.prismic.io/carwow/da024fea-3ccd-4e9a-99d2-aad65bcec58b_2021+BMW+M3+front+quarter+moving+2.jpg',
    'https://germanauto.co.uk/wp-content/uploads/2021/07/Featued-Image-BMW.png',
    'https://www.topgear.com/sites/default/files/2022/09/1-BMW-3-Series.jpg',
    'https://a.storyblok.com/f/143588/2100x1330/7b88b45e27/bmw-128ti-2020-260923.jpg/m/filters:quality(80)',
    'https://images.prismic.io/carwow/a033e549-c253-4214-8162-79ca6e41fbf0_2022+BMW+X1+front+quarter+moving+2.jpg?auto=format&cs=tinysrgb&fit=crop&q=60&w=750',
    'https://a.storyblok.com/f/143588/1600x1013/ea336faae7/3fd11466-41b1-40d6-9d2b-e280cf457d3c_bmwm2.jpg/m/fit-in/960x639/filters:quality(80)',
    'https://car-images.bauersecure.com/wp-images/4680/bmw_xm_19.jpg',
    'https://www.inchcape.co.uk/media/55shzuhl/components-featured-block-content-1000x562-desktop-bmw-1-series-2024-1.jpg?v=1db09b713aa88d0'
  ],
  'PORSCHE' => [
    'https://newsroom.porsche.com/.imaging/mte/porsche-templating-theme/image_1290x726/dam/pnr/2024/Products/992-II/0840_nevada_coupe_u-crane_AKOS0607_edit_V03-sky.jpg/jcr:content/0840_nevada_coupe_u-crane_AKOS0607_edit_V03-sky.jpg',
    'https://images-porsche.imgix.net/-/media/BCE0DDD35E7E4D9CA16F7DA7480B8E92_EDD06986A16144F2B898A6A0E0034E4C_BX24I3HOX0040_desktop?iar=0&w=640&ar=3%3A4&q=85&auto=format',
    'https://images-porsche.imgix.net/-/media/DE9B7F8D1C6948F1AF6B4114B75C3F3A_9B859437D4CE4E3BBDF51C13778126C0_Nevada---Desktop?iar=0&w=640&ar=3%3A4&q=85&auto=format',
    'https://images-porsche.imgix.net/-/media/BA984301AA8F495AB2E08123AC9D55DE_1B9AFC90D73B4971AA008F19EB44DBAA_NEW-Taycan---Desktop?iar=0&w=640&ar=3%3A4&q=85&auto=format',
    'https://images-porsche.imgix.net/-/media/AD24345646AA45B7B04D01140FD13E64_2BE518066FDF4865830DA9B63F8FAACF_NEW-Panamera---Desktop?iar=0&w=640&ar=3%3A4&q=85&auto=format',
    'https://images-porsche.imgix.net/-/media/D9863281BEC14473AE2EAD15A724142B_EC1FCFC6C9714D01A26B1EE755DA137B_Berlin---Desktop?iar=0&w=640&ar=3%3A4&q=85&auto=format',
    'https://images-porsche.imgix.net/-/media/657C1C9232C0426583987BC10E7EAE09_5E4EF4AC80B8448CB8011C7D23D88269_Cayenne---Desktop?iar=0&w=640&ar=3%3A4&q=85&auto=format',
    'https://www.topgear.com/sites/default/files/2024/07/_V2A3789_1.jpg',
    'https://cdn.whichcar.com.au/assets/w_3000/d5b2152c/2024-porsche-718-cayman-coupe-crayon-1.jpg',
    'https://www.topgear.com/sites/default/files/cars-car/image/2022/03/1-Porsche-Cayman-GT4-RS.jpg',
    'https://www.stratstone.com/-/media/stratstone/blog/2018/5-glorious-ways-to-spec-the-new-porsche-911/porsche-911-turbo-s-1280x720px.ashx?mh=1440&la=en&h=720&w=1280&mw=2560&hash=46ABC397D2CF9CED58603E6CFA36DDD4'
  ],
  'MERCEDES-BENZ' => [
    'https://www.topgear.com/sites/default/files/2021/11/Mercedes_C300D_0000.jpg',
    'https://dorsiafinance.co.uk/wp-content/uploads/10-Facts-About-Mercedes-Benz.webp',
    'https://www.gearpatrol.com/wp-content/uploads/sites/2/2023/12/23c0381-020-source-65779290bb85b-jpg.webp',
    'https://www.mercedes-benz.co.uk/content/united-kingdom/en/passengercars/models/coupe/c236-23-2/overview/_jcr_content/root/responsivegrid/tabs/tabitem/hotspot_module/hotspot_simple_image.component.damq1.3399158690119.jpg/mercedes-benz-cle-coupe-c236-exterior-highlights-hotspot-start-3302x1858-06-2023.jpg',
    'https://www.topgear.com/sites/default/files/cars-car/image/2024/01/1%20Mercedes%20GLC%20Coupe%20review.jpg',
    'https://www.mercedes-benzworld.co.uk/media/zs5hiwqz/driver-experiences.jpg?anchor=center&mode=crop&width=1440&quality=80&heightratio=.75&rnd=133669900623930000',
     'https://group.mercedes-benz.com/bilder/unternehmen/news/2021/absatz-2021-01-w1680xh945-cutout.jpg',
     'https://www.autocar.co.uk/sites/autocar.co.uk/files/styles/gallery_slide/public/mercedes-eqs-suv-review-2024-01-tracking-front.jpg?itok=PhLYaj0U',
      'https://www.stratstone.com/-/media/stratstone/blog/2022/what-is-mercedes-4matic/mercedes-amg-e-class-1920x774px.ashx'
  ],
  'AUDI' => [
    'https://uploads.audi-mediacenter.com/system/production/media/70272/images/3c92d2acbf6ab5f85be8006f854786f0f0ff36be/A1813681_web_2880.jpg?1698341967',
    'https://www.topgear.com/sites/default/files/cars-car/image/2023/09/33136-RS7PERFORMANCEASCARIBLUEJORDANBUTTERS208.jpg',
    'https://hips.hearstapps.com/hmg-prod/images/original-13270-s7-2024-6701-66d8a83a30973.jpg?crop=0.647xw:0.456xh;0.115xw,0.211xh&resize=700:*',
    'https://assets-eu-01.kc-usercontent.com/fb793c58-315a-0196-d3af-7c9c2613d52c/6455254b-a960-464a-92be-fb5bcb6fed07/a6.jpg?w=1280&q=75&lossless=true&auto=format',
    'https://a.storyblok.com/f/143588/1600x1014/30b0ea5cb4/ef17a9e8-1984-44bd-a9bf-389bb8251d07_audi-e-tron-gt.jpg/m/filters:quality(80)',
    'https://www.topgear.com/sites/default/files/cars-car/image/2023/06/AudiRS6Avant%20performance_Dewsilver_matt071.jpg',
    'https://car-images.bauersecure.com/wp-images/3649/073-audi-a5.jpg',
    'https://a.storyblok.com/f/143588/2100x1400/7af5081faa/2022_r8_rwd-dean_smith-021.jpg/m/fit-in/960x639/filters:quality(80)',
    'https://www.thecarexpert.co.uk/wp-content/uploads/2022/09/33159-RS7Sportbackperformance-2133x1200-cropped.jpeg',
    'https://www.pooleaudi.co.uk/media/images/52345016/1.jpg'
  ],
  'JAGUAR' => [
    'https://www.topgear.com/sites/default/files/cars-car/image/2021/01/jag_xf_21my_driving_270121_5346.jpg',
    'https://di-uploads-pod18.dealerinspire.com/germainjaguar/uploads/2020/06/JE_2021-Jaguar-F-Type.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ1GmvYTtomrUBaeXIkDueUBW30hP2ecHHPGg&s',
    'https://di-uploads-pod18.dealerinspire.com/germainjaguar/uploads/2021/01/JE_2021-Jaguar-F-Pace.jpg',
    'https://images.prismic.io/carwow/ZrZDR0aF0TcGI1Gy_2021JaguarXFFront3QDriving02.jpg',
    'https://www.goodwood.com/globalassets/.road--racing/road/news/2020/8-august/list-jaguar-concepts/best-jaguar-concept-cars-9-jaguar-c-x75-goodwood-24082020.jpg?rxy=0.5,0.5&width=640&height=360',
    'https://dealerinspire-image-library-prod.s3.us-east-1.amazonaws.com/images/8msFMM6UPa4IeoAbDtn7nmveiyGyAfe0dQwO1CTz.jpg',
    'https://di-uploads-pod18.dealerinspire.com/germainjaguar/uploads/2020/11/lineup-Jaguar-21XF.jpg',
    'https://jlr.scene7.com/is/image/jlr/Jag_GTSV_Location_on_the_track_161220'

  ],
  'MASERATI' => [
    'https://maserati.scene7.com/is/image/maserati/maserati/international/model-page/quattroporte/design/214300M-exterior%20(1).jpg?$1400x2000$&fit=constrain',
    'https://www.topgear.com/sites/default/files/2024/02/1-Maserati-GranTurismo.jpg',
    'https://resources.formula-e.pulselive.com/photo-resources/2024/04/16/9835b996-8480-4433-8673-0a9a6794f252/2-23855-MaseratiGranCabrioFolgore.jpg?width=1440&height=810',
    'https://maserati.scene7.com/is/image/maserati/maserati/regional/hk/2023/model-image/menu_nav_gt.png?$1920x2000$&fmt=png-alpha&fit=constrain',
    'https://maserati.scene7.com/is/image/maserati/maserati/regional/bg/cpo/retail_maseratiapproved_ghibli_1920x1080.jpg?$1400x2000$&fit=constrain',
    'https://media.autoexpress.co.uk/image/private/s--X-WVjvBW--/f_auto,t_content-image-full-desktop@1/v1695123907/autoexpress/2023/09/Maserati%20GranTurismo%202023-6.jpg',
    'https://bluesky-cogcms-prodb.cdn.imgeng.in/media/cugfonr1/20092-maseratigranturismofolgore.jpg?width=1000&height=660&mode=crop&scale=both&quality=60',
    'https://www.stellantis.com/content/dam/stellantis-corporate/brands/maserati/gallery/Maserati-GranCabrio-Trofeo.jpg',
    'https://www.cnet.com/a/img/resize/278e9de7e06f092ba7ea7b908b0e4a7385ee11fb/hub/2022/08/03/e0bd6562-c587-455d-a644-c45cd7c13c8d/2022-maserati-mc20-006.jpg?auto=webp&width=768',
    'https://i.ytimg.com/vi/Z7WW7r8S-AI/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLBFjLpxW2YB2zqhDhMMtfelueJpYg'
  ],
  'ROLLS-ROYCE' => [
    'https://www.topgear.com/sites/default/files/2024/01/1%20Rolls-Royce%20Cullinan%20review.jpg',
    'https://www.topgear.com/sites/default/files/cars-car/image/2023/07/LIPMAN_JL93884_0.jpg',
    'https://cdn.motor1.com/images/mgl/13jgw/s3/rolls-royce-black-badge-wraith-by-spofec.jpg',
    'https://media.autoexpress.co.uk/image/private/s--X-WVjvBW--/f_auto,t_content-image-full-desktop@1/v1711382433/autoexpress/2024/03/Rolls-Royce%20Spectre%20UK%202024-23.jpg',
    'https://www.rolls-roycemotorcarsranchomirage.com/static/dealer-12176/2022-rolls-royce-phantom-mmp-1-1634759496.jpeg',
    'https://m.atcdn.co.uk/vms/media/w1920/119571ce9f53491da3e02f2cd817fa26.jpg',
    'https://hips.hearstapps.com/hmg-prod/images/p90508471-highres-rolls-royce-ghost-ex-copy-64dbcad7a198e.jpg?crop=0.622xw:0.437xh;0.160xw,0.415xh&resize=2048:*',
    'https://evpowered.co.uk/wp-content/uploads/2024/03/P90528768_highRes_rolls-royce-spectre-scaled.jpg'
  ],
  'BUGATTI' => [
    'https://newsroom.cdn.bugatti-media.com/a32c5a46-eb09-4a6f-ac28-35622dde9d4d/xl',
    'https://assets.bwbx.io/images/users/iqjWHBFdfxIU/iQ34To9OcH.4/v2/1200x800.jpg',
    'https://www.rightreg.co.uk/assets/media/186-51045728403f11ca478bdb.jpg',
    'https://revolutionwatch.com/wp-content/uploads/2024/06/BUGATTI-Tourbillon-1-1600x900.jpeg',
    'https://cdn.motor1.com/images/mgl/VzMq0z/s1/bugatti-chiron-1500.jpg',
    'https://supercarblondie.com/wp-content/uploads/everything-we-know-bugatti-chiron-successor-feature.webp',
    'https://www.motortrend.com/uploads/sites/5/2021/05/Bugatti-Chiron.jpg?w=768&width=768&q=75&format=webp',
    'https://live.mrf.io/statics/i/ps/cleantechnica.com/wp-content/uploads/2024/06/Bugatti-Tourbillon-front-three-quarter.jpg?width=1200&enable=upscale'
  ]

}


owner_names = []
40.times do
  owner_names << Faker::Name.name
end

owners = owner_names.map do |name|
  Owner.find_or_create_by!(nickname: name)
end

service = NhtsaApiService.new
brands = [
  'porsche', 'lamborghini', 'ferrari', 'bmw', 'audi', 'mercedes', 'jaguar',
  'maserati', 'rolls-royce', 'bugatti' ]
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

        car_image_url = image_urls[brand_name]&.sample || 'https://via.placeholder.com/300x200?text=No%20Image'

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






puts "Seeded #{Car.count} cars."
