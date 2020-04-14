# frozen_string_literal: true

puts 'Введите а:'
a = gets.chomp.to_i
puts 'Введите b:'
b = gets.chomp.to_i
puts 'Введите c:'
c = gets.chomp.to_i
desc = b**2 - 4 * a * c

def find_solution(a, b, _c, desc)
  x1 = (-b + Math.sqrt(desc)) / (2 * a)
  x2 = (-b - Math.sqrt(desc)) / (2 * a)
  puts "Первый корень: #{x1}"
  puts "Второй корень: #{x2}"
end

if desc == 0
  puts "Один корень:#{(-b) / (2 * a)}"
elsif desc.negative?
  puts 'Нет решения'
else
  find_solution(a, b, c, desc)
end
