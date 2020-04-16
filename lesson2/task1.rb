# frozen_string_literal: true

MONTHS_2020 = {
  'Январь' => 31,
  'Февраль' => 29,
  'Март' => 31,
  'Апрель' => 30,
  'Май' => 31,
  'Июнь' => 30,
  'Июль' => 31,
  'Август' => 30,
  'Сентябрь' => 30,
  'Октябрь' => 31,
  'Ноябрь' => 30,
  'Декабрь' => 31
}.freeze

MONTHS_2020.each do |month, days_num|
  puts month.to_s if days_num == 30
end
