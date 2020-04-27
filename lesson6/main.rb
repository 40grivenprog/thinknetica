# frozen_string_literal: true

# Этот файл является примером того, как работает программа
require_relative 'train'
require_relative 'station'
require_relative 'route'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'carriage'
require_relative 'carriage_passenger'
require_relative 'carriage_cargo'
require 'terminal-table'
require_relative 'instance_counter'
require_relative 'validation'
require 'pry'
class Visual
  attr_reader :stations
  include Validation
  def initialize
    @trains = []
    @stations = []
    @carriages = []
    @routes = []
  end

  def start
    loop do
      main_menu
      choice = gets.chomp.to_i
      return unless valid_choice?((0..9), choice)
      case choice
      when 1
        create_station
      when 2
        create_train
      when 3
        create_route
      when 4
        route_for_train
      when 5
        carriages_method('add')
      when 6
        carriages_method('remove')
      when 7
        move_train
      when 8
        statistic_by_station
      when 9
        stations_method
      else
        break
      end
    end
  end

  private

  def statictic
    table = Terminal::Table.new do |t|
      t << ["Станции: #{@stations.length}"]
      t <<  ["Поезда: #{@trains.length}"]
      t <<  ["Маршруты: #{@routes.length}"]
    end
    puts table
  end

  def main_menu
    statictic
    table = Terminal::Table.new do |t|
      t << ['1 - Создать станцию']
      t << ['2 - Создать поезд']
      t << ['3 - Создать маршрут']
      t << ['4 - Назначать маршрут поезду']
      t << ['5 - Добавить вагон к поезду']
      t << ['6 - Отцепить вагоны от поезда']
      t << ['7 - Перемещать поезд по маршруту вперед и назад']
      t << ['8 - Просматривать список станций и список поездов на станции']
      t << ['9 - Управлять маршрутом']
      t << ['0 - Выход']
    end
    puts table
  end

  def create_station
    warning_table('Создать станцию')
    choice = gets.chomp.to_i
    return unless valid_choice?((0..1), choice)
    if choice == 1
      attemp = 1
      loop do
        puts 'Введите название станции:'
        name = gets.chomp
        if valid_name? name
          @stations << Station.new(name)
          puts "Создана новая станция: #{@stations.last.name}"
          break
        elsif attemp >= 3
          break
        end
        puts "У вас осталось #{3 - attemp} попыток"
        attemp += 1
      end
    end
  end

  def create_train
    warning_table('Создать поезд')
    choice = gets.chomp.to_i
    return unless valid_choice?((0..1), choice)
    if choice == 1
      attemp = 1
      loop do
        puts 'Введите номер поезда'
        number = gets.chomp
        if valid_number? number
          puts 'Выберите тип поезд: 1 - Пассажирский, 2 - Грузовой'
          type = gets.chomp.to_i
          return unless valid_choice?((1..2), type)

          @trains << (type == 1 ? PassengerTrain.new(number) : CargoTrain.new(number))
          puts "Новый поезд создан: #{@trains.last.number}"
          break
        elsif attemp >= 3
          brake
        end
        puts "У вас осталось #{3 - attemp} попыток"
        attemp += 1
      end
    end
    end

  def create_route
    if @stations.length < 2
      return puts 'Что бы создать маршрут необходимо создать две станции'
end

    warning_table('Создать маршрут')
    choice = gets.chomp.to_i
    return unless valid_choice?((0..1), choice)
    if choice == 1
      puts 'Выберите первую станцию:'
      first_station = select_from(@stations)
      puts 'Выберите вторую станцию:'
      second_station = select_from(@stations)
      if first_station == second_station
        return puts 'Нельзя выбирать две одинаковые станции'
  end

      @routes << Route.new(first_station, second_station)
      puts "Создан новый маршрут: #{@routes.last.stations.map(&:name).join(' -> ')}"
    end
  end

  def route_for_train
    if @routes.empty? || @trains.empty?
      return puts 'Что бы задать маршрут поезду необходимо иметь один поезд и один маршрут'
end

    warning_table('Задать маршрут')
    choice = gets.chomp.to_i
    return unless valid_choice?((0..1), choice)
    if choice == 1
      puts 'Выберите поезд:'
      train = select_from(@trains)
      puts 'Выберите маршрут:'
      route = select_from(@routes)
      "Поезд номер #{train.number} будет следовать по маршруту #{route.stations.map(&:name).join('->')}"
      train.take_route(route)
    end
  end

  def select_from(list)
    list.each do |element|
      puts "#{list.index(element) + 1} - #{element.number}" if list == @trains
      if list == @routes
        puts "#{list.index(element) + 1} - #{element.stations.map(&:name).join('->')}"
 end
      puts "#{list.index(element) + 1} - #{element.name}" if list == @stations
    end
    choice = gets.chomp.to_i
    list[choice - 1] if choice - 1 <= list.length
  end

  def warning_table(param)
    table = Terminal::Table.new do |t|
      t << ["1 - #{param}"]
      t << ['0 - Выйти']
    end
    puts table
  end

  def carriages_method(param)
    train = select_from(@trains)
    train.stop unless train.speed.zero?
    if param == 'add'
      train.type == 'cargo' ? train.add_carriage(CarriageCargo.new) : train.add_carriage(CarriagePassenger.new)
    else
      train.remove_carriage(train.carriages.last)
    end
  end

  def move_train
    return puts 'Ни одного поезда на маршруте' unless has_route?

    warning_table('Управлять поездом на маршруте')
    choice = gets.chomp.to_i
    if choice == 1
      trains = @trains.reject { |train| train.route.nil? }
      return if trains

      current_train = select_from(trains)
      puts '1 - Вперёд'
      puts '2 - Назад'
      choice = gets.chomp.to_i
      current_train.go_next if choice == 1
      current_train.go_back if choice == 2
    end
  end

  def has_route?
    @trains.reject { |train| train.route.nil? }
  end

  def stations_method
    if @routes.empty? || @stations.length <= 2
      return puts 'У вас нет маршрутов или недостаточно станций'
end

    warning_table('Управлять маршрутом')
    choice = gets.chomp.to_i
    if choice == 1
      puts 'Выберите маршрут'
      current_route = select_from(@routes)
      puts '1 - Добавить новую станцию'
      puts '2 - Удалить станцию'
      update_route(current_route, 'add') if gets.chomp.to_i == 1
      update_route(current_route, 'remove') if gets.chomp.to_i == 2
    end
  end

  def update_route(route, param)
    station = select_from @stations
    if param == 'add'
      route.add_between_station(station)
    else
      route.remove_between_station(station)
    end
  end

  def statistic_by_station
    @stations.each do |station|
      puts "#{stations.index(station) + 1} - #{station.name}"
      get_carriages_num(station.trains)
    end
  end

  def get_carriages_num(trains)
    trains.each do |train|
      puts "#{train.number} has #{train.carriages.length} carriages."
    end
  end
end

# a = Visual.new
# a.start
