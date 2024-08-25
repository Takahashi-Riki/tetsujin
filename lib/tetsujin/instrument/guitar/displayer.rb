# frozen_string_literal: true

module Tetsujin::Instrument
  class Guitar::Displayer
    FRET_CHAR_WITDH = 7.freeze # 例えば "A♯4/B♭4" など最大7文字
    STRING_NUMBER_WITDH = 2.freeze # 例えば "12" など最大2文字を想定
    private_constant :FRET_CHAR_WITDH

    # @param guitar [Tetsujin::Instrument::Guitar]
    # @return [void]
    def print_fretboard(guitar)
      guitar.strings.sort_by(&:string_number).each{ |string| display_string(string) }
      display_fretboard_numbers(guitar.fretboard_length)
    end

    private

    attr_reader :guitar

    # @example
    #  " 1 : -------      F4 -------      G4 G♯4/A♭4 ------- A♯4/B♭4 -------      C5 C♯5/D♭5 ------- D♯5/E♭5 -------"
    def display_string(string)
      frets = string.frets.map{ |fret| fret_representation(fret) }.join(" ")
      puts [string_number_representation(string.string_number), frets].join(" ")
    end

    # @example
    #  "   :       0       1       2       3       4       5       6       7       8       9      10      11      12"
    def display_fretboard_numbers(fretboard_length)
      fretnumbers = (0..fretboard_length).to_a.map { |fret_number| fretboard_number_representation(fret_number) }.join(" ")
      puts [string_number_representation(""), fretnumbers].join(" ")
    end

    # @example
    #  "A♯4/B♭4"
    #  "-------"
    def fret_representation(fret)
      fret_char_width = 7
      fret.pressed? ? fret.note.to_s.rjust(fret_char_width) : "-" * fret_char_width
    end

    # @example
    #  1 => " 1 :"
    def string_number_representation(string_number)
      "#{string_number.to_s.rjust(string_number_width)} :"
    end

    # @example
    #  1 => "      1"
    def fretboard_number_representation(fret_number)
      fret_number.to_s.rjust(fretboard_number_width)
    end

    def fretboard_number_width
      FRET_CHAR_WITDH
    end

    def string_number_width
      STRING_NUMBER_WITDH
    end
  end
end
