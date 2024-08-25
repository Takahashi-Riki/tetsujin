# frozen_string_literal: true

require_relative "dsl/theory"
require_relative "dsl/instrument"

module Tetsujin
  module DSL
    include Tetsujin::DSL::Theory
    include Tetsujin::DSL::Instrument
  end
end
