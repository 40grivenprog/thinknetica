# frozen_string_literal: true

require_relative 'train'
class PassengerTrain < Train
  def initialize
    super
    @type = 'passenger'
  end
end
