# frozen_string_literal: true

require_relative 'manufacturer'
require_relative 'instance_counter'
require 'pry'
class Carriage
  include Manufacturer
  include InstenceCounter
  attr_reader :type, :free_param_quantity

  def initialize(param_quantity)
    @param_quantity = param_quantity
    @free_param_quantity = param_quantity
  end

  def take_by_param(param = 1)
    if (@free_param_quantity - param).negative?
      raise 'Нет столько свободного места'
    end

    @free_param_quantity -= param
  rescue StandardError => e
    puts e.message
    nil
  end

  def not_free_by_param
    @param_quantity - @free_param_quantity
  end
end
