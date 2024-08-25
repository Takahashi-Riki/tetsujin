# frozen_string_literal: true

module Tetsujin::Instrument
  class Guitar::String
    attr_reader :tuning, :fretboard_length, :string_number

    # @param tuning [Tetsujin::Theory::Note] チューニング
    # @param string_number [Integer] 弦番号
    # @param fretboard_length [Integer] フレット数
    def initialize(tuning:, string_number:, fretboard_length: 22)
      raise TypeError unless tuning.is_a?(Tetsujin::Theory::Note)
      raise TypeError unless string_number.is_a?(Integer)
      raise TypeError unless fretboard_length.is_a?(Integer)

      @tuning = tuning
      @string_number = string_number
      @fretboard_length = fretboard_length
    end

    # @return [Tetsujin::Instrument::Guitar::Frets]
    def frets
      @_frets ||= generate_frets
    end

    # @param fret_number [Integer]
    # @return [Tetsujin::Instrument::Guitar::Fret]
    def [](fret_number)
      frets.find_by_fret_number(fret_number)
    end

    # @param notes [Enumerable<Tetsujin::Theory::Note>] each でループした際に Note オブジェクトが取得できる Enumerable
    # @return [void]
    def play!(notes)
      notes.each { |note| frets.play!(note) }
    end

    # @param fret_number [Integer]
    # @return [void]
    def press!(fret_number)
      frets.press!(fret_number)
    end

    # @return [void]
    def release!
      frets.release!
    end

    # @param other [Tetsujin::Instrument::Guitar::String]
    # @return [Boolean]
    def ==(other)
      tuning == other.tuning && string_number == other.string_number && fretboard_length == other.fretboard_length
    end

    private

    def generate_frets
      frets = (0..fretboard_length).map do |fret_number|
        interval = Tetsujin::Theory::Interval.new(value: fret_number)
        Tetsujin::Instrument::Guitar::Fret.new(note: tuning.add(interval), string_number: string_number, fret_number: fret_number)
      end
      Tetsujin::Instrument::Guitar::Frets.new(frets: frets)
    end
  end
end
