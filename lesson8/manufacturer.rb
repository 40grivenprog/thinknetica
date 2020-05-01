# frozen_string_literal: true

module Manufacturer
  attr_accessor :manufacturer
  def add_manufacturer(manufacturer)
    @manufacturer = manufacturer
  end
end
