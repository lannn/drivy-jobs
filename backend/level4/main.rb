require "date"
require "json"
require "./car.rb"
require "./rental.rb"
require "./action.rb"

input_file = File.read("./data/input.json")
input_hash = JSON.parse(input_file, symbolize_names: true)

cars = input_hash[:cars].map do |car_hash|
  Car.new(car_hash)
end

rentals = input_hash[:rentals].map do |rental_hash|
  rental_hash[:car] = cars.detect { |c| c.id == rental_hash[:car_id] }
  Rental.new(rental_hash)
end

actors = ["driver", "owner", "insurance", "assistance", "drivy"]

output_rentals = rentals.map do |rental|
  actions = actors.map do |actor|
    action = Action.new(rental, actor)

    {
      who: action.actor,
      type: action.type,
      amount: action.amount
    }
  end

  {
    id: rental.id,
    actions: actions
  }
end

rentals_hash = { rentals: output_rentals }

File.open("./data/output.json", "w") do |f|
  f.write(JSON.pretty_generate(rentals_hash))
end
