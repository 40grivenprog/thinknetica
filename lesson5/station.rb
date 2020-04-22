# frozen_string_literal: true

# This class characterizes Station according to requirements
class Station
  attr_reader :trains, :name
  @@stations = []
    include InstenceCounter

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    register_instance
  end

  def trails_list
    @trains.map(&:number)
  end

  def self.all
    @@stations
  end

  def trains_list_by_type
    cargo = []
    passenger = []
    @trains.each do |train|
      if train.type == cargo
        cargo << train
      else
        passenger << train
      end
    end
    "Cargo: #{cargo.length}. Passenger: #{passenger.length}"
  end

  def take_train(train)
    @trains << train
    train.speed = 0
  end

  def leave_train(train)
    @trains.delete(train)
  end
end
