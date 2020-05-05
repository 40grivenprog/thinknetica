# frozen_string_literal: true

require_relative 'train'
class PassengerTrain < Train
  validate(:number, :presence, true)
  validate(:number, :param_type, String)
  validate(:number, :format, NUMBER_FORMAT)

  def initialize(number)
    @type = 'passenger'
    super(number)
  end
end
