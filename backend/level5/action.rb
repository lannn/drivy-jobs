class Action
  attr_reader :actor

  def initialize(rental, actor)
    @rental = rental
    @actor = actor
  end

  def type
    case actor
    when "driver"
      "debit"
    else
      "credit"
    end
  end

  def amount
    case actor
    when "driver"
      rental.price + total_price_for_options
    when "owner"
      rental.price * 70 / 100 + owner_amount_from_options
    when "insurance"
      rental.commission.insurance_fee
    when "assistance"
      rental.commission.assistance_fee
    when "drivy"
      rental.commission.drivy_fee + drivy_amount_from_options
    end
  end

  private

  attr_reader :rental

  def total_price_for_options
    rental
      .options
      .inject(0) { |sum, option| sum + option.price * rental.number_of_days }
  end

  def owner_amount_from_options
    rental
      .options
      .select { |option| ["gps", "baby_seat"].include?(option.type) }
      .inject(0) { |sum, option| sum + option.price * rental.number_of_days }
  end

  def drivy_amount_from_options
    rental
      .options
      .select { |option| ["additional_insurance"].include?(option.type) }
      .inject(0) { |sum, option| sum + option.price * rental.number_of_days }
  end
end
