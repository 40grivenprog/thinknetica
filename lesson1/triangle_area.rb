# frozen_string_literal: true

puts 'Основание:'
ground = gets.chomp.to_i
puts 'Высота:'
height = gets.chomp.to_i
def check_valid(ground, height)
  params = [ground, height]
  true if params.select(&:negative?).empty?
end
puts area = 0.5 * ground * height if check_valid(ground, height)
