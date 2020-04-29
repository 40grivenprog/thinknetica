# frozen_string_literal: true

require 'pry'
module Validation
  NAME_FORMAT = /^[а-яА-я]{3,}$/.freeze
  NUMBER_FORMAT = /^\w{3}-\w{2}\z|^\w{5}\z/.freeze
  def validate_name!(name)
    raise 'Имя должно быть текстовыми содержать более трёх символов. Попробуйте ещё раз. ' unless name.match NAME_FORMAT
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

  def validate_number!(number)
    raise 'Номер не соответсвует формату из требований' unless number.match? NUMBER_FORMAT
  end
end
