class Commission

  def initialize(rental)
    @rental = rental
  end

  def total_fee
    rental.price * 30 / 100
  end

  def insurance_fee
    total_fee * 50 / 100
  end

  def assistance_fee
    rental.number_of_days * 100
  end

  def drivy_fee
    total_fee - insurance_fee - assistance_fee
  end

  private

  attr_reader :rental
end
