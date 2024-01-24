# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Clear existing records
PerformanceDetail.destroy_all
Car.destroy_all
User.destroy_all

# Create a user
user = User.create!(
  user_name: 'admin',
  email: 'admin@admin.com',
  password: 'password' #either use faker or create a random password
)

# Create cars with performance details
cars_data = [
  {
    model_name: 'Model S',
    image: 'https://digitalassets.tesla.com/tesla-contents/image/upload/f_auto,q_auto/Mega-Menu-Vehicles-Model-S.png',
    description: 'Model S Plaid has the quickest acceleration of any vehicle in production...',
    rental_price: 150,
    performance_details: [
      '359 mi Range (EPA est.)',
      '1.99 s 0-60 mph*',
      '200 mph Top Speed†',
      '1,020 hp Peak Power'
    ]
  },
  {
    model_name: 'Model 3',
    image: 'https://digitalassets.tesla.com/tesla-contents/image/upload/f_auto,q_auto/Mega-Menu-Vehicles-Model-3-LHD.png',
    description: 'Model 3 benefits from the same features that make our other vehicles so safe...',
    rental_price: 120,
    performance_details: [
      '15 min Recharge up to 175 miles†',
      '341 mi Range (EPA est.)',
      'AWD Dual Motor'
    ]
  },
  {
    model_name: 'Model X',
    image: 'https://digitalassets.tesla.com/tesla-contents/image/upload/f_auto,q_auto/Mega-Menu-Vehicles-Model-X.png',
    description: 'With the most power and quickest acceleration of any SUV, Model X Plaid is...',
    rental_price: 160,
    performance_details: [
      '326 mi Range (EPA est.)',
      '2.5 s 0-60 mph*',
      '9.9s 1/4 Mile',
      '1,020 hp Peak Power'
    ]
  },
  {
    model_name: 'Model Y',
    image: 'https://digitalassets.tesla.com/tesla-contents/image/upload/f_auto,q_auto/Mega-Menu-Vehicles-Model-Y.png',
    description: 'Plenty of range for every kind of drive. From daily driving to family road trips...',
    rental_price: 140,
    performance_details: [
      '310 mi Range (EPA est.)',
      '76 cu ft Cargo Space',
      '9.9s 1/4 Mile',
      'AWD Dual Motor'
    ]
  },
  {
    model_name: 'Cybertruck',
    image: 'https://digitalassets.tesla.com/tesla-contents/image/upload/f_auto,q_auto/Mega-Menu-Vehicles-Cybertruck-1x.png',
    description: 'Haul everything you need with 2,500 pounds payload and 11,000 pounds towing capacity...',
    rental_price: 180,
    performance_details: [
      '340 mi Est. Range',
      '11,000 lbs Towing Capacity',
      '2.6s 0-60 Mph'
    ]
  }
]

cars_data.each do |car_data|
    car = user.cars.create!(
      model_name: car_data[:model_name],
      image: car_data[:image],
      description: car_data[:description],
      rental_price: car_data[:rental_price]
    )
  
    car_data[:performance_details].each do |performance_detail_data|
      car.performance_details.create!(detail: performance_detail_data)
    end
end
