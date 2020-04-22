# frozen_string_literal: true

require_relative 'train'
class CargoTrain < Train
  def initialize
    super
    @type = 'cargo'
  end
end
