# frozen_string_literal: true

module Tetsujin
  module DSL
    module Instrument
      # @param fretboard_length [Integer] フレット数
      # @return [Tetsujin::Instrument::Guitar]
      def regular_tuning_guitar(fretboard_length:)
        tunings = [
          Tetsujin::Theory::Note.new(pitch_class:  4, octave: 2),
          Tetsujin::Theory::Note.new(pitch_class:  9, octave: 2),
          Tetsujin::Theory::Note.new(pitch_class:  2, octave: 3),
          Tetsujin::Theory::Note.new(pitch_class:  7, octave: 3),
          Tetsujin::Theory::Note.new(pitch_class: 11, octave: 3),
          Tetsujin::Theory::Note.new(pitch_class:  4, octave: 4)
        ]
        guitar(tunings: tunings, fretboard_length: fretboard_length)
      end

      # @param tunings [Array<Tetsujin::Theory::Note>] チューニング 低い方から順に
      # @param fretboard_length [Integer] フレット数
      def guitar(tunings:, fretboard_length:)
        Tetsujin::Instrument::Guitar::Factory.create(tunings: tunings, fretboard_length: fretboard_length)
      end

      # @param guitar [Tetsujin::Instrument::Guitar]
      # @return [void]
      def display_guitar(guitar)
        displayer = Tetsujin::Instrument::Guitar::Displayer.new
        guitar.print_fretboard(displayer)
      end
    end
  end
end
