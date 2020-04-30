# frozen_string_literal: true

class CarriagePassenger < Carriage
  def initialize(param)
    super(param)
    @type = 'passenger'
  end
end
