require "date"
require "json"

class Car
  attr_reader :id, :price_per_day, :price_per_km

  def initialize(params)
    @id = params[:id].to_i
    @price_per_day = params[:price_per_day].to_i
    @price_per_km = params[:price_per_km].to_i
  end

end

class Rental
  attr_reader :id, :car, :start_date, :end_date, :distance

  def initialize(params)
    @id = params[:id].to_i
    @car = params[:car]
    @start_date = Date.parse(params[:start_date]).to_date
    @end_date = Date.parse(params[:end_date]).to_date
    @distance = params[:distance].to_i
  end

  def price
    price_by_day + price_by_distance
  end

  private

  def price_by_day
    car.price_per_day * (1 + (end_date - start_date).to_i)
  end

  def price_by_distance
    car.price_per_km * distance
  end
end

input_file = File.read("data/input.json")
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

File.open("data/output.json", "w") do |f|
  f.write(JSON.pretty_generate(rentals_output))
end
