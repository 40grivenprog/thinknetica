# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validation'
# This class characterizes Station according to requirements
class Station
  attr_reader :trains, :name
  @@stations = []
  include InstenceCounter
  include Validation
  def initialize(name)
    validate_name! name
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

  def add_name
    loop do
      puts 'Введите название станции:'
      name = gets.chomp
      if valid_name? name
        break
      elsif attemp >= 3
        break
      end
      puts "У вас осталось #{3 - attemp} попыток"
      attemp += 1
      end
  end

  def take_train(train)
    @trains << train
    train.speed = 0
  end

  def leave_train(train)
    @trains.delete(train)
  end
end
