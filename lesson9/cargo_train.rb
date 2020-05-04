# frozen_string_literal: true

require_relative 'train'
require_relative 'validation'
class CargoTrain < Train
  validate(:number, :presence, true)
  validate(:number, :type, String)
  validate(:number, :format, NUMBER_FORMAT)

  def initialize(number)
    @type = 'cargo'
    super(number)
  end
end
