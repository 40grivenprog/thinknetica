# frozen_string_literal: true

# This class characterizes Route according to requirements
class Route
  attr_reader :stations
    include InstenceCounter

  def initialize(from, to)
    @from = from
    @to = to
    @stations = [@from, @to]
    register_instance
  end

  def list_of_stations
    @stations.map(&:name)
  end

  def add_between_station(station)
    return puts 'Станция уже присутствует' if @stations.include? station

    @stations.insert(-2, station)
  end

  def remove_between_station(station)
    if [@from, @to].include? station
      return puts 'Вы не можете удалить конечные станции маршрута'
    end
    return puts 'Нет такой станции' if @stations.delete(station).nil?
  end
end
