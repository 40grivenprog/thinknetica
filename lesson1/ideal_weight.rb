# frozen_string_literal: true

puts 'Введите ваше имя:'
name = gets.chomp
puts 'Введите свой рост:'
length = gets.chomp.to_i
return if length.negative?
ideal_weight = (length - 110) * 1.15
if ideal_weight.negative?
  puts 'Ваш вес уже оптимальный'
else
  puts "#{name}, ваш идеальный вес это #{ideal_weight}"
end
