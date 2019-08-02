require "test/unit"
require "./car.rb"
require "./rental.rb"
require "./commission.rb"

class MainTest < Test::Unit::TestCase

  def test_commission_split
    car = Car.new(id: 1, price_per_day: 2_000, price_per_km: 10)
    rental = Rental.new(id: 1, car: car, start_date: "2017-12-8", end_date: "2017-12-8", distance: 100)
    commission = Commission.new(rental)
    assert_equal 450, commission.insurance_fee, "Rental 1 should return insurance fee 450"
    assert_equal 100, commission.assistance_fee, "Rental 1 should return assistance fee 100"
    assert_equal 350, commission.drivy_fee, "Rental 1 should return assistance fee 350"
  end

end
