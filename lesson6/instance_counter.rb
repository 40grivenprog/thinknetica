# frozen_string_literal: true

module InstenceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
 end

  module ClassMethods
    attr_reader :instances_counter
    def counter
      @instances_counter ||= 0
      @instances_counter += 1
    end
  end

  module InstanceMethods
    private

    def register_instance
      self.class.counter
    end
  end
end
