require "date"

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
    days = 1 + (end_date - start_date).to_i

    (1..days).inject(0) do |sum, day|
      sum + car.price_per_day * (100 - discount_percent(day)) / 100
    end
  end

  def discount_percent(day)
    case day
    when 1..1
      0
    when 2..4
      10
    when 5..10
      30
    else
      50
    end
  end

  def price_by_distance
    car.price_per_km * distance
  end
end
