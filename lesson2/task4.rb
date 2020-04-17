# frozen_string_literal: true

alphabet = ('а'..'я').to_a
vowel = %w[у е ы а о э я и ю]
result_hash = {}
alphabet.each_with_index do |letter, letter_num|
  result_hash[letter] = letter_num + 1 if vowel.include? letter
end
puts result_hash
