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
      rental.price +
        rental.options.inject(0) { |sum, option| sum + option.price * rental.number_of_days }
    when "owner"
      rental.price * 70 / 100 + amount_for_other_options
    when "insurance"
      rental.commission.insurance_fee
    when "assistance"
      rental.commission.assistance_fee
    when "drivy"
      rental.commission.drivy_fee + additional_insurance_amount
    end
  end

  private

  attr_reader :rental

  def amount_for_other_options
    rental
      .options
      .select { |option| ["gps", "baby_seat"].include?(option.type) }
      .inject(0) { |sum, option| sum + option.price * rental.number_of_days }
  end

  def additional_insurance_amount
    rental
      .options
      .select { |option| option.type == "additional_insurance" }
      .inject(0) { |sum, option| sum + option.price * rental.number_of_days }
  end
end
