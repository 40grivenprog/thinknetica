# frozen_string_literal: true

# Этот файл является примером того, как работает программа
require_relative 'train'
require_relative 'station'
require_relative 'route'
moscow = Station.new('Moscow')
minsk = Station.new('Minsk')
riga = Station.new('Riga')
moscow_minsk = Route.new(moscow, minsk)
moscow_minsk.add_between_station(riga)
train = Train.new(1, 3)
train2 = Train.new(0, 3)
train.take_route(moscow_minsk)
train.go_next
moscow.trains_list_by_type
