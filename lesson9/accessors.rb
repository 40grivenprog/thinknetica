# frozen_string_literal: true

module Accessor
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      history = "@#{name}_history".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        if instance_variable_get(history).nil?
          instance_variable_set(history, [])
        end
        instance_variable_set(var_name, value)
        instance_variable_get(history) << value
      end
      define_method("#{name}_history") { instance_variable_get(history) }
    end
  end

  def strong_attr_accessor(name, className)
    var_name = "@#{name}".to_sym
    define_method(name) { instance_variable_get(var_name) }
    define_method("#{name}=".to_sym) do |value|
      if value.class == className
        instance_variable_set(var_name, value)
      else
        raise 'Неверный формат'
      end
    end
  end
end
