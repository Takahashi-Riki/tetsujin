module Tetsujin::Instrument
  class Guitar::Factory
    # @param tunings [Array<Tetsujin::Theory::Note>] チューニング 低い方から順に
    # @param fretboard_length [Integer] フレット数
    # @return [Tetsujin::Instrument::Guitar]
    def self.create(tunings:, fretboard_length:)
      strings = tunings.reverse.map.with_index(1) do |tuning, string_number|
        Tetsujin::Instrument::Guitar::String.new(
          tuning: tuning,
          string_number: string_number,
          fretboard_length: fretboard_length
        )
      end
      Tetsujin::Instrument::Guitar.new(strings: strings)
    end
  end
end
