# frozen_string_literal: true

puts 'Основание:'
ground = gets.chomp.to_f
puts 'Высота:'
height = gets.chomp.to_f
def check_valid(ground, height)
  params = [ground, height]
  true if params.select {|param| param <= 0}.empty?
end
puts check_valid(ground, height) ? 0.5 * ground * height : "Неверное условие"
