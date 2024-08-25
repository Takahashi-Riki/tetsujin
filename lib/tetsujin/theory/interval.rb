# frozen_string_literal: true

module Tetsujin::Theory
  class Interval
    attr_reader :value

    # @param value [Integer] 度数
    def initialize(value:)
      raise TypeError unless value.is_a?(Integer)
      @value = value
    end

    # @param other [Tetsujin::Theory::Interval]
    # @return [Boolean]
    def ==(other)
      value == other.value
    end
  end
end
