# frozen_string_literal: true

require_relative 'manufacturer'
require_relative 'instance_counter'
require 'pry'
class Carriage
  include Manufacturer
  include InstenceCounter
  attr_reader :type
  def initialize; end
end
