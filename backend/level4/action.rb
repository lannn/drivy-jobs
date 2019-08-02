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
      rental.price
    when "owner"
      rental.price * 70 / 100
    when "insurance"
      rental.commission.insurance_fee
    when "assistance"
      rental.commission.assistance_fee
    when "drivy"
      rental.commission.drivy_fee
    end
  end

  private

  attr_reader :rental
end
