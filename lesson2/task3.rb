res = [0, 1]
res.each do |num|
	res.last + res[-2] > 100 ? break : res << res.last + res[-2]
end
puts res