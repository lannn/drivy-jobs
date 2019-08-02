require "date"
require "json"
require "./car.rb"
require "./rental.rb"

input_file = File.read("./data/input.json")
input_hash = JSON.parse(input_file, symbolize_names: true)

cars = input_hash[:cars].map do |car_hash|
  Car.new(car_hash)
end

rentals = input_hash[:rentals].map do |rental_hash|
  rental_hash[:car] = cars.detect { |c| c.id == rental_hash[:car_id] }
  Rental.new(rental_hash)
end

rentals_with_price = rentals.map { |rental| { id: rental.id, price: rental.price }}
rentals_output = { rentals: rentals_with_price }

File.open("./data/output.json", "w") do |f|
  f.write(JSON.pretty_generate(rentals_output))
end
