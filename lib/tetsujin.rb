# frozen_string_literal: true

require_relative "tetsujin/version"

# ------------- Theory -------------
require_relative "tetsujin/theory"

# Note
require_relative "tetsujin/theory/note"
require_relative "tetsujin/theory/notes"
require_relative "tetsujin/theory/note/factory"

# Scale
require_relative "tetsujin/theory/scale"

# Interval
require_relative "tetsujin/theory/interval"

# ------------- Instrument -------------
require_relative "tetsujin/instrument"

# Guitar
require_relative "tetsujin/instrument/guitar"
require_relative "tetsujin/instrument/guitar/string"
require_relative "tetsujin/instrument/guitar/fret"
require_relative "tetsujin/instrument/guitar/frets"
require_relative "tetsujin/instrument/guitar/displayer"
require_relative "tetsujin/instrument/guitar/factory"

# ------------- DSL -------------
require_relative "tetsujin/dsl"
require_relative "tetsujin/dsl/theory"
require_relative "tetsujin/dsl/instrument"

module Tetsujin
  include Tetsujin::DSL
end
