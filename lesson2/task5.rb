months_days = {
	1 => 31,
	2 => 29,
	3 => 31,
	4 => 30,
	5 => 31,
	6 => 30,
	7 => 31,
	8 => 31,
	9 => 30,
	10 => 31,
	11 => 30,
	12 => 31
}
puts "Year:"
year = gets.chomp.to_i
puts "Month:"
month = gets.chomp.to_i
puts "Day"
day = gets.chomp.to_i
def calculate(year, day, month, months_days)
	months_days[2] = 30 if year % 400 == 0 || (year % 4 == 0 && year % 100 != 0)
	months_days.values.take(month - 1).sum + day
end

puts calculate(year, day, month, months_days)