# frozen_string_literal: true

module Validation
  NAME_FORMAT = /^[а-яА-я]$/.freeze
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
        validate_presence(validation) if validation[:type] == :presence
        validate_type(validation) if validation[:type] == :type
        validate_format(validation) if validation[:type] == :format
      end
    end

    def validate_presence(validation)
      attr = send validation[:attribute]
      raise CustomError, 'Параметр не может быть пустым.' if attr == ''
    end

    def validate_type(validation)
      attr = send validation[:attribute]
      unless attr.is_a? validation[:format]
        raise CustomError, 'Данное поле должно быть строкой.'
      end
    end

    def validate_format(validation)
      attr = send validation[:attribute]
      unless attr.match validation[:format]
        raise CustomError, 'Данное поле не соответствует нужному формату.'
      end
    end
  end
end
