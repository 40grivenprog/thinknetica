# frozen_string_literal: true

res = [0, 1]
res.each do |_num|
  res.last + res[-2] > 100 ? break : res << res.last + res[-2]
end
puts res
