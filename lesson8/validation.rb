# frozen_string_literal: true

require 'pry'
module Validation
  NAME_FORMAT = /^[а-яА-я]{3,}$/.freeze
  NUMBER_FORMAT = /^\w{3}-\w{2}\z|^\w{5}\z/.freeze
  class ChoiceError < StandardError
  end
  class NameError < StandardError
  end
  class NumberError < StandardError
  end
  def validate_name!(name)
    raise NameError, 'Имя должно быть текстовыми содержать более трёх символов. Попробуйте ещё раз. ' unless name.match NAME_FORMAT
  end

  def valid_choice?(variants, choice)
    raise ChoiceError, 'Нет такого варианта ответа.' unless variants.include? choice
  end

  def validate_number!(number)
    raise NumberError, 'Номер не соответсвует формату из требований' unless number.match? NUMBER_FORMAT
  end
end
