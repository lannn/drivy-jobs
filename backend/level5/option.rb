class Option
  attr_reader :id, :rental_id, :type

  def initialize(params)
    @id = params[:id].to_i
    @rental_id = params[:rental_id]
    @type = params[:type]
  end

  def price
    case type
    when "gps"
      5 * 100
    when "baby_seat"
      2 * 100
    when "additional_insurance"
      10 * 100
    end
  end
end
