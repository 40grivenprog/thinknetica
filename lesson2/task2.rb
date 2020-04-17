# frozen_string_literal: true

res = []
num = 10
while num <= 100
  res << num if num % 5 == 0
  num += 1
end
