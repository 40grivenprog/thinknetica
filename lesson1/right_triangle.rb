# frozen_string_literal: true

puts 'Первая сторона:'
a = gets.chomp.to_i
puts 'Вторая сторона:'
b = gets.chomp.to_i
puts 'Третья сторона:'
c = gets.chomp.to_i
sides = [a, b, c]

def check_right(sides)
  sides.sort!
  true if sides[2]**2 == sides[1]**2 + sides[0]**2
end

def check_valid(sides)
  false if sides.select(&:negative?).empty?
end

check_valid(sides)
if !check_valid(sides)
  puts 'Невалидная сторона'
  return
elsif sides.uniq.length == 1
  puts 'Равносторонний'
elsif sides.uniq.length == 2
  puts 'Равнобедренный'
elsif check_right(sides)
  puts 'Прямоугольный'
end
