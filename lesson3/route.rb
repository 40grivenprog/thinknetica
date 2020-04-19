# frozen_string_literal: true

# This class characterizes Route according to requirements
class Route
  attr_reader :stations
  def initialize(from, to)
    @from = from
    @to = to
    @stations = [@from, @to]
  end

  def list_of_stations
    @stations.map(&:name)
  end

  def add_between_station(station)
    return 'This station already present' if @stations.include? station

    @stations.insert(-2, station)
  end

  def remove_between_station(station)
    return 'There is no such staion' if @stations.delete(station).nil?
  end
end
