# frozen_string_literal: true

module Validation
  NAME_FORMAT = /^[а-яА-я]*$/.freeze
  NUMBER_FORMAT = /^\w{3}-\w{2}\z|^\w{5}\z/.freeze

  class ChoiceError < StandardError
  end
  class CustomError < StandardError
  end

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :validates
    def validate(attribute, type, format)
      @validates ||= []
      @validates << { attribute: attribute, type: type, format: format }
    end
  end

  module InstanceMethods
    def valid_choice?(variants, choice)
      unless variants.include? choice
        raise ChoiceError, 'Нет такого варианта ответа.'
      end
    end

    def validate!
      self.class.validates.each do |validation|
        attribute, type, format = validation[:attribute], validation[:type], validation[:format]
        send type, attribute, format
      end
    end

    def presence(attribute, format)
      attr = send attribute
      raise CustomError, 'Параметр не может быть пустым.' if attr == ''
    end

    def param_type(attribute, format)
      attr = send attribute
      unless attr.is_a? format
        raise CustomError, 'Данное поле должно быть строкой.'
      end
    end

    def format(attribute, format)
      attr = send attribute
      unless attr.match format
        raise CustomError, 'Данное поле не соответствует нужному формату.'
      end
    end
  end
end
