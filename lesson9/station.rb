# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validation'
# This class characterizes Station according to requirements
class Station
  attr_reader :trains, :name
  @@stations = []
  include InstenceCounter
  include Validation
  validate(:name, :presence, true)
  validate(:name, :param_type, String)
  validate(:name, :format, NAME_FORMAT)
  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    register_instance
    validate!
  end

  def trails_list
    @trains.map(&:number)
  end

  def self.all
    @@stations
  end

  def each_train
    @trains.each do |train|
      yield(train)
    end
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
    attemp = 0
    loop do
      puts 'Введите название станции:'
      name = gets.chomp
      break if valid_name? name

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
