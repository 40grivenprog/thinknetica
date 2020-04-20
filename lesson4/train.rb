# frozen_string_literal: true

require 'pry'
# This class characterizes Route according to requirements
class Train
  attr_reader :carriages, :number, :type, :route
  attr_accessor :speed
  def initialize
    @number = rand(10_000..99_999)
    @carriages = []
    @speed = 0
  end

  def increase_speed(speed_to_increase)
    @speed += speed_to_increase
  end

  def stop
    @speed = 0
  end

  def add_carriage(carriage)
    if @speed.zero?
      @carriages << carriage
    end
  end

  def remove_carriage(carriage)
      if @speed.zero?
      @carriages.delete carriage
    end
  end

  def take_route(route)
    @route = route
    @route.stations.first.take_train(self)
  end

  def current_station
    @route.stations.find { |station| station.trains.include? self }
  end

  def go_next
    @speed = 30 if @speed == 0
    return puts 'Это последняя станция' if current_station == @route.stations.last

    next_station = find_station 'next'
    current_station.leave_train(self)
    next_station.take_train(self)
  end

  def go_back
    return puts 'Это первая станция' if current_station == @route.stations.first

    @speed = 30 if @speed == 0
    previous_station = find_station 'previous'
    current_station.leave_train(self)
    previous_station.take_train(self)
  end

  def next_station
    return puts 'Нет следующей станции' if current_station == @route.stations.last

    find_station('next').name
  end

  def previous_station
    return puts 'Нет предыдущей станции' if current_station == @route.stations.first

    find_station('back').name
  end

  def current_station_name
    current_station.name
  end

  private

  def find_station(param)
    if param == 'next'
      station_num = @route.stations.index(current_station)
      @route.stations[station_num + 1]
    else
      station_num = @route.stations.index(current_station)
      @route.stations[station_num - 1]
    end
  end
end
