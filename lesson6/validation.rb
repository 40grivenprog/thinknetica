# frozen_string_literal: true

require 'pry'
module Validation
  NAME_FORMAT = /^[а-яА-я]{3,}$/.freeze
  NUMBER_FORMAT = /^\w{3}-\w{2}\z|^\w{5}\z/.freeze
  def valid_name?(name)
    unless name.match NAME_FORMAT
      raise 'Имя должно быть текстовыми содержать более трёх символов. Попробуйте ещё раз. '
 end

    true
  rescue StandardError => e
    puts e.message
    false
  end

  def valid_choice?(variants, choice)
  if variants.include? choice
   true
 else
    raise 'Нет такого варианта ответа.'
  end
  rescue StandardError => e
    puts e.message
  end

  def valid_number?(number)
    unless number.match? NUMBER_FORMAT
      raise 'Номер не соответсвует формату из требований'
 end

    true
  rescue StandardError => e
    puts e.message
    false
  end
end