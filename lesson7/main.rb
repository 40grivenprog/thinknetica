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

      valid_choice?((0..11), choice)
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
        statistic
      when 9
        stations_method
      when 10
        take_seat
      when 11
        take_volume
      else
        break
      end
    end
  rescue ChoiceError => e
    puts e.message
    retry
  end

  private

  def info_statistic
    table = Terminal::Table.new do |t|
      t << ["Станции: #{@stations.length}"]
      t <<  ["Поезда: #{@trains.length}"]
      t <<  ["Маршруты: #{@routes.length}"]
    end
    puts table
  end

  def main_menu
    info_statistic
    table = Terminal::Table.new do |t|
      t << ['1 - Создать станцию']
      t << ['2 - Создать поезд']
      t << ['3 - Создать маршрут']
      t << ['4 - Назначать маршрут поезду']
      t << ['5 - Добавить вагон к поезду']
      t << ['6 - Отцепить вагоны от поезда']
      t << ['7 - Перемещать поезд по маршруту вперед и назад']
      t << ['8 - Статистика']
      t << ['9 - Управлять маршрутом']
      t << ['10 - Занять место']
      t << ['11 - Занять объём']
      t << ['0 - Выход']
    end
    puts table
  end

  def create_station(attemp = 1)
    warning_table('Создать станцию')
    choice = gets.chomp.to_i
    valid_choice?((0..1), choice)
    if choice == 1
      puts 'Введите имя станции'
      name = gets.chomp
      @stations << Station.new(name)
      puts "Создана новая станция: #{@stations.last.name}"
    end
  rescue NameError => e
    if attemp < 3
      puts e.message
      puts "У вас осталось #{3 - attemp} попыток"
      attemp += 1
      retry
    else
      raise e.message
    end
  end

  def create_train(attemp = 1)
    warning_table('Создать поезд')
    choice = gets.chomp.to_i
    if choice == 1
      puts 'Выберите тип поезд: 1 - Пассажирский, 2 - Грузовой'
      type = gets.chomp.to_i
      valid_choice?((1..2), type)
      puts 'Введите номер поезда:'
      number = gets.chomp
      @trains << (type == 1 ? PassengerTrain.new(number) : CargoTrain.new(number))
      puts "Новый поезд создан: #{@trains.last.number}"
      end
  rescue NumberError => e
    if attemp < 3
      puts e.message
      puts "У вас осталось #{3 - attemp} попыток"
      attemp += 1
      retry
    else
      raise e.message
    end
    end

  def create_route
    if @stations.length < 2
      return puts 'Что бы создать маршрут необходимо создать две станции'
end

    warning_table('Создать маршрут')
    choice = gets.chomp.to_i
    valid_choice?((0..1), choice)
    if choice == 1
      puts 'Выберите первую станцию:'
      first_station = select_from(@stations) { |station| puts "#{@stations.index(station) + 1} - #{station.name}" }
      puts 'Выберите вторую станцию:'
      second_station = select_from(@stations) { |station| puts "#{@stations.index(station) + 1} - #{station.name}" }
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
    valid_choice?((0..1), choice)
    if choice == 1
      puts 'Выберите поезд:'
      train = select_from(@trains) { |train| puts "#{@trains.index(train) + 1} - #{train.number}" }
      puts 'Выберите маршрут:'
      route = select_from(@routes) { |route| puts "#{@routes.index(route) + 1} - #{route.stations.map(&:name).join('->')}" }
      "Поезд номер #{train.number} будет следовать по маршруту #{route.stations.map(&:name).join('->')}"
      train.take_route(route)
    end
  end

  def select_from(list)
    list.each do |element|
      yield(element)
    end
    choice = gets.chomp.to_i
    valid_choice?((1..list.length), choice)
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
    train = select_from(@trains) { |train| puts "#{@trains.index(train) + 1} - #{train.number}" }
    train.stop unless train.speed.zero?
    if param == 'add'
      plus_carriage(train)
    else
      train.remove_carriage(train.carriages.last)
    end
  end

  def plus_carriage(train)
    if train.type == 'cargo'
      puts 'Введите объём:'
      volume = gets.chomp.to_i
      @carriages << CarriageCargo.new(volume)
      train.add_carriage(@carriages.last)
    else
      puts 'Введите количество пассажирских мест.'
      number = gets.chomp.to_i
      @carriages << CarriagePassenger.new(number)
      train.add_carriage(@carriages.last)
    end
  end

  def move_train
    return puts 'Ни одного поезда на маршруте' unless has_route?

    warning_table('Управлять поездом на маршруте')
    choice = gets.chomp.to_i
    valid_choice?((0..1), choice)
    if choice == 1
      trains = @trains.reject { |train| train.route.nil? }
      return unless trains

      current_train = select_from(trains) { |train| puts "#{@trains.index(train) + 1} - #{train.number}" }
      puts '1 - Вперёд'
      puts '2 - Назад'
      choice = gets.chomp.to_i
      valid_choice?((1..2), choice)
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
    valid_choice?((0..1), choice)
    if choice == 1
      puts 'Выберите маршрут'
      current_route = select_from(@routes) { |route| puts "#{@routes.index(route) + 1} - #{route.stations.map(&:name).join('->')}" }
      puts '1 - Добавить новую станцию'
      puts '2 - Удалить станцию'
      valid_choice?((1..2), choice)
      update_route(current_route, 'add') if gets.chomp.to_i == 1
      update_route(current_route, 'remove') if gets.chomp.to_i == 2
    end
  end

  def update_route(route, param)
    station = select_from(@stations) { |station| puts "#{@stations.index(station) + 1} - #{station.name}" }
    if param == 'add'
      route.add_between_station(station)
    else
      route.remove_between_station(station)
    end
  end

  def statistic
    puts '1 - Статистика по станциям.'
    puts '2 - Статистика по поедам.'
    puts '0 - Выход.'
    choice = gets.chomp.to_i
    valid_choice?((0..2), choice)
    if choice == 1
      station = select_from(@stations) { |station| puts "#{@stations.index(station) + 1} - #{station.name}" }
      return 'Нет поездов на станиции' if station.trains.empty?

      station.each_train do |train|
        puts "Номер поезда #{train.number}. Количество вагонов #{train.carriages.length}"
      end
    elsif choice == 2
      train = select_from(@trains) { |train| puts "#{@trains.index(train) + 1} - #{train.number}" }
      return 'У данного поезда нет вагонов' if train.carriages.empty?

      train.each_carriage do |carriage|
        puts "#{train.carriages.index(carriage) + 1} вагон - Свободно: #{carriage.free_param_quantity}. Занято: #{carriage.not_free_by_param}."
      end
    end
  end

  def take_seat
    passenger_trains = @trains.select { |train| train.type == 'passenger' }
    raise 'Нет пассажирских поездов' if passenger_trains.empty?

    warning_table('Занять место')
    choice = gets.chomp.to_i
    valid_choice?((0..1), choice)
    carriage = get_carriage(passenger_trains)
    carriage.take_by_param
  rescue StandardError => e
    puts e.message
  end

  def take_volume
    cargo_trains = @trains.select { |train| train.type == 'cargo' }
    raise 'Нет грузовых поездов' if cargo_trains.empty?

    warning_table('Занять объём')
    choice = gets.chomp.to_i
    valid_choice?((0..1), choice)
    carriage = get_carriage(cargo_trains)
    puts 'Введите объём который нужно занять'
    volume = gets.chomp.to_i
    carriage.take_by_param(volume)
  rescue StandardError => e
    puts e.message
  end

  def get_carriage(trains)
    puts 'Выберите поезд'
    train = select_from(trains) { |train| puts "#{trains.index(train) + 1} - #{train.number}" }
    raise 'У данного поезда нет вагонов' if train.carriages.empty?

    select_from(train.carriages) do |carriage|
      puts "#{train.carriages.index(carriage) + 1} - Свободно: #{carriage.free_param_quantity}. Занятно: #{carriage.not_free_by_param}"
    end
  end
end
a = Visual.new
a.start
