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

class Visual
	attr_reader :stations
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
		 t <<	["Поезда: #{@trains.length}"]
		 t <<	["Маршруты: #{@routes.length}"]
		end
		puts table
	end

	def main_menu
		statictic
		table = Terminal::Table.new do |t|
			t << ["1 - Создать станцию"]
			t << ["2 - Создать поезд"]
			t << ["3 - Создать маршрут"]
			t << ["4 - Назначать маршрут поезду"]
			t << ["5 - Добавить вагон к поезду"]
			t << ["6 - Отцепить вагоны от поезда"]
			t << ["7 - Перемещать поезд по маршруту вперед и назад"]
			t << ["8 - Просматривать список станций и список поездов на станции"]
			t << ["9 - Управлять маршрутом"]
			t << ["0 - Выход"]
		end
		puts table
	end

	def create_station
		warning_table("Создать станцию")
		choice = gets.chomp.to_i
		if choice == 1
			puts "Введите название станции:"
			name = gets.chomp
			@stations << Station.new(name)
		else
			return
		end
	end

	def create_train
		warning_table("Создать поезд")
		choice = gets.chomp.to_i
		if choice == 1
			puts "Выберите тип поезд: 1 - Пассажирский, 2 - Грузовой"
			type = gets.chomp.to_i
			return unless [1,2].include? type
			type == 1 ? @trains << PassengerTrain.new : @trains << CargoTrain.new
		else
			return
		end
		end

		def create_route
			return puts "Что бы создать маршрут необходимо создать две станции" if @stations.length < 2
			warning_table("Создать маршрут")
			choice = gets.chomp.to_i
			if choice == 1
				puts "Выберите первую станцию:"
				first_station = select_from(@stations)
				puts "Выберите вторую станцию:"
				second_station = select_from(@stations)
				return puts "Нельзя выбирать две одинаковые станции" if first_station == second_station
				@routes << Route.new(first_station, second_station)
			else
			return
		end
		end

		def route_for_train
			return puts "Что бы задать маршрут поезду необходимо иметь один поезд и один маршрут" if @routes.length < 1 || @trains.length < 1
			warning_table("Задать маршрут")
			choice = gets.chomp.to_i
			if choice == 1
				puts "Выберите поезд:"
				train = select_from(@trains)
				puts "Выберите маршрут:"
				route = select_from(@routes)
				"Поезд номер #{train.number} будет следовать по маршруту #{route.stations.map(&:name).join('->')}"
				train.take_route(route)
			else
				return
			end
		end

		def select_from(list)
			list.each do |element|
				puts "#{list.index(element) + 1} - #{element.number}" if list == @trains
				puts "#{list.index(element) + 1} - #{element.stations.map(&:name).join('->')}" if list == @routes
				puts "#{list.index(element) + 1} - #{element.name}" if list == @stations
			end
			choice = gets.chomp.to_i
			if choice - 1 <= list.length
				list[choice - 1]
			else
				return
			end
		end

		def warning_table(param)
			table = Terminal::Table.new do |t|
				t << ["1 - #{param}"]
				t << ["0 - Выйти"]
			end
		puts table
		end

		def carriages_method(param)
			train = select_from(@trains)
			train.stop unless train.speed.zero?
			if param == 'add'
				binding.pry
				train.type == 'cargo' ? train.add_carriage(CarriageCargo.new) : train.add_carriage(CarriagePassenger.new)
			else
				train.remove_carriage(train.carriages.last)
			end
		end

		def move_train
			return puts "Ни одного поезда на маршруте" unless has_route?
			warning_table("Управлять поездом на маршруте")
			choice = gets.chomp.to_i
			if choice == 1
				trains = @trains.select {|train| train.route != nil}
				return if trains
				current_train = select_from(trains)
				puts "1 - Вперёд"
				puts "2 - Назад"
				choice = gets.chomp.to_i
				current_train.go_next if choice == 1
				current_train.go_back if choice == 2
			else
				return
			end
		end

		def has_route?
			@trains.select {|train| train.route != nil}
		end

		def stations_method
			return puts "У вас нет маршрутов или недостаточно станций" if @routes.length < 1 || @stations.length <= 2
			warning_table("Управлять маршрутом")
			choice = gets.chomp.to_i
			if choice == 1
				puts "Выберите маршрут"
				current_route = select_from(@routes)
				puts "1 - Добавить новую станцию"
				puts "2 - Удалить станцию"
				update_route(current_route, 'add') if gets.chomp.to_i == 1
				update_route(current_station, 'remove') if gets.chomp.to_i == 2
			else
				return
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

a = Visual.new
a.start
