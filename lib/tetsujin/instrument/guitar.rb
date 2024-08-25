# frozen_string_literal: true

module Tetsujin::Instrument
  class Guitar
    attr_reader :strings

    def initialize(strings:)
      raise TypeError unless strings.is_a?(Array)
      raise TypeError unless strings.all? { |string| string.is_a?(Tetsujin::Instrument::Guitar::String) }
      @strings = strings
    end

    # @param notes [Enumerable<Tetsujin::Theory::Note>] each でループした際に Note オブジェクトが取得できる Enumerable
    # @return [void]
    def play!(notes)
      strings.each { |string| string.play!(notes) }
    end

    # @param string_number [Integer]
    # @param fret_number [Integer]
    # @return [void]
    def press!(string_number, fret_number)
      find_string(string_number).press!(fret_number)
    end

    # @return [void]
    def release!
      strings.each(&:release!)
    end

    # @param string_number [Integer]
    # @return [Tetsujin::Instrument::Guitar::String]
    def [](string_number)
      strings.find { |string| string.string_number == string_number }
    end
    alias find_string []

    # @return [Integer]
    def fretboard_length
      strings.map(&:fretboard_length).max
    end

    # @param displayer [Tetsujin::Instrument::Guitar::Displayer] フレットボードを表示するための Displayer オブジェクト
    # @example
    # 1:      E4 ------- F♯4/G♭4      G4 -------      A4 -------      B4 ------- C♯5/D♭5 ------- ------- -------
    # 2: ------- ------- -------      D4 -------      E4 ------- F♯4/G♭4      G4 -------      A4 -------      B4
    # 3: ------- ------- ------- ------- ------- ------- -------      D4 -------      E4 ------- F♯4/G♭4      G4
    # 4: ------- ------- ------- ------- ------- ------- ------- ------- ------- ------- ------- -------      D4
    # 5: ------- ------- ------- ------- ------- ------- ------- ------- ------- ------- ------- ------- -------
    # 6: ------- ------- ------- ------- ------- ------- ------- ------- ------- ------- ------- ------- -------
    #          0       1       2       3       4       5       6       7       8       9      10      11      12
    def print_fretboard(displayer)
      displayer.print_fretboard(self)
    end

    # @param other [Tetsujin::Instrument::Guitar]
    # @return [Boolean]
    def ==(other)
      strings.sort_by(&:string_number) == other.strings.sort_by(&:string_number)
    end
  end
end
