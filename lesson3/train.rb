# frozen_string_literal: true

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
    @current_station_num = 1
  end

  def go_next
    if @current_station_num == @route.stations.length
      return 'This is final station'
    end

    @speed = 30 if @speed == 0
    @route.stations[@current_station_num - 1].leave_train(self)
    @current_station_num += 1
    @route.stations[@current_station_num - 1].take_train(self)
  end

  def go_back
    return 'This is first station' if @current_station_num == 1

    @speed = 30 if @speed == 0
    @route.stations[@current_station_num - 1].leave_train(self)
    @current_station_num -= 1
    @route.stations[@current_station_num - 1].take_train(self)
  end
end
