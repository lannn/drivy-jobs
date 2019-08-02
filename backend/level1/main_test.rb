require "test/unit"
require "./car.rb"
require "./rental.rb"

class MainTest < Test::Unit::TestCase
  def test_price_for_a_rental
    car = Car.new(id: 1, price_per_day: 2000, price_per_km: 10)
    rental = Rental.new(id: 1, car: car, start_date: "2017-12-8", end_date: "2017-12-10", distance: 100)
    assert_equal 7000, rental.price, "Rental 1 should return price 7000"
  end
end
