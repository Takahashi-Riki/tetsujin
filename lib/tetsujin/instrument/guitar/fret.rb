# frozen_string_literal: true

module Tetsujin::Instrument
  class Guitar::Fret
    attr_reader :note, :string_number, :fret_number

    # @param note [Tetsujin::Theory::Note] 音
    # @param string_number [Integer] 弦番号
    # @param fret_number [Integer] フレット番号
    def initialize(note:, string_number:, fret_number:)
      raise TypeError unless note.is_a?(Tetsujin::Theory::Note)
      raise TypeError unless string_number.is_a?(Integer)
      raise TypeError unless fret_number.is_a?(Integer)

      @note = note
      @string_number = string_number
      @fret_number = fret_number
      @pressed = false
    end

    # @param other [Tetsujin::Instrument::Guitar::Fret]
    # @return [Boolean]
    def ==(other)
      note == other.note && string_number == other.string_number && fret_number == other.fret_number
    end

    # @return [Boolean] フレットが押されているか
    def pressed?
      pressed
    end

    # @return [void]
    def press!
      @pressed = true
    end

    # @return [void]
    def release!
      @pressed = false
    end

    private

    attr_reader :pressed
  end
end
