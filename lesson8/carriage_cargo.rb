# frozen_string_literal: true

class CarriageCargo < Carriage
  def initialize(param)
    super(param)
    @type = 'cargo'
  end
end
