# frozen_string_literal: true
require 'pry'
# This class characterizes Route according to requirements
class Train
  attr_reader :carriage_num, :number, :speed, :type
  def initialize(type, carriage_num)
    @type = type.zero? ? 'cargo' : 'passenger'
    @number = rand(10_000..99_999)
    @carriage_num = carriage_num
    @speed = 0
  end

  def increase_speed(speed_to_increase)
    @speed += speed_to_increase
  end

  def stop
    @speed = 0
  end

  def drop_carriages(number_to_drop)
    return 'Speed must be 0' if @speed > 0
    return 'There are no so many carriages' if number_to_drop > @carriage_num

    @carriage_num -= number_to_drop
  end

  def add_carriages(num_to_add)
    return 'Speed must be 0' if @speed > 0

    @carriage_num += num_to_add
  end

  def take_route(route)
    @route = route
    @route.stations.first.take_train(self)
  end

  def current_station
  	@route.stations.find {|station| station.trains.include? self}
  end

  def go_next
    @speed = 30 if @speed == 0
    return "This is last station" if current_station == @route.stations.last
    next_station = find_station 'next'
    current_station.leave_train(self)
    next_station.take_train(self)
  end

  def go_back
    return 'This is first station' if current_station == @route.stations.first
    @speed = 30 if @speed == 0
    previous_station = find_station 'previous'
    current_station.leave_train(self)
    previous_station.take_train(self)
  end

  def next_station
  	return 'No next station' if current_station == @route.stations.last
  	find_station('next').name
  end

  def previous_station
  	return 'No previous stations' if current_station == @route.stations.first
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
