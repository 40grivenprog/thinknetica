# frozen_string_literal: true

res = {}
def ask(res)
  puts 'Product name?'
  name = gets.chomp
  return summa(res) if name == 'Stop'

  puts 'Product price?'
  price = gets.chomp.to_f
  puts 'Product quantity?'
  quantity = gets.chomp.to_f
  res[name] = { price => quantity }
  ask(res)
end

def summa(res)
  sum = 0
  res.values.each do |i|
    sum += i.keys[0] * i.values[0]
  end
  puts res
  puts "Итоговая цена: #{sum}"
end
ask(res)
