require "test/unit"
require "./car.rb"
require "./rental.rb"

class MainTest < Test::Unit::TestCase
  def test_price_for_1_day
    car = Car.new(id: 1, price_per_day: 2_000, price_per_km: 10)
    rental = Rental.new(id: 1, car: car, start_date: "2017-12-8", end_date: "2017-12-8", distance: 100)
    assert_equal 3_000, rental.price, "Rental 1 should keep price 2000"
  end

  def test_price_after_1_day
    car = Car.new(id: 1, price_per_day: 2000, price_per_km: 10)
    rental = Rental.new(id: 2, car: car, start_date: "2017-12-8", end_date: "2017-12-9", distance: 300)
    assert_equal 6_800, rental.price, "Rental 2 should decrease price per day 10% after 1 day"
  end

  def test_price_after_4_days
    car = Car.new(id: 1, price_per_day: 2000, price_per_km: 10)
    rental = Rental.new(id: 3, car: car, start_date: "2017-12-8", end_date: "2017-12-13", distance: 500)
    assert_equal 15_200, rental.price, "Rental 3 should decrease price per day 30% after 4 days"
  end

  def test_price_after_10_days
    car = Car.new(id: 1, price_per_day: 2000, price_per_km: 10)
    rental = Rental.new(id: 4, car: car, start_date: "2017-12-3", end_date: "2017-12-14", distance: 1000)
    assert_equal 27_800, rental.price, "Rental 4 should decrease price per day 50% after 10 days"
  end
end
