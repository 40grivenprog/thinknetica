# frozen_string_literal: true

puts 'Введите а:'
a = gets.chomp.to_i
puts 'Введите b:'
b = gets.chomp.to_i
puts 'Введите c:'
c = gets.chomp.to_i
desc = b**2 - 4 * a * c

def find_solution(a, b, _c, desc)
	if desc.zero?
  "Один корень:#{(-b) / (2 * a)}"
	elsif desc.negative?
  	'Нет решения'
	else
  	x1 = (-b + Math.sqrt(desc)) / (2 * a)
  	x2 = (-b - Math.sqrt(desc)) / (2 * a)
  	"Первый корень: #{x1}, второй корень: #{x2}"
	end
end
puts [a,b,c].select(&:zero?).empty?  ? find_solution(a, b, c, desc) : "Не является квадратным уравнением"
