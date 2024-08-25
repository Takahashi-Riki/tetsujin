# frozen_string_literal: true

module Tetsujin::Instrument
  class Guitar::Frets
    extend Forwardable
    def_delegators :frets, :each, :map, :find, :size

    attr_reader :frets

    # @param frets [Array<Tetsujin::Instrument::Guitar::Fret>] フレットの配列
    def initialize(frets:)
      raise TypeError unless frets.all? { |fret| fret.is_a?(Tetsujin::Instrument::Guitar::Fret) }
      @frets = frets
    end

    # @param note [Tetsujin::Theory::Note]
    def ==(other)
      self_sorted = frets.sort do |a, b|
        [a.string_number, a.fret_number] <=> [b.string_number, b.fret_number]
      end
      other_sorted = other.frets.sort do |a, b|
        [a.string_number, a.fret_number] <=> [b.string_number, b.fret_number]
      end
      self_sorted == other_sorted
    end

    # @param note [Tetsujin::Theory::Note]
    # @return [void]
    def play!(note)
      find_by_note(note)&.press!
    end

    # @param fret_number [Integer]
    # @return [void]
    def press!(fret_number)
      find_by_fret_number(fret_number).press!
    end

    # @return [void]
    def release!
      frets.each(&:release!)
    end

    # @param fret_number [Integer] フレット番号
    # @return [Tetsujin::Instrument::Guitar::Fret]
    def find_by_fret_number(fret_number)
      frets.find { |fret| fret.fret_number == fret_number }
    end

    # @param note [Tetsujin::Theory::Note]
    # @return [Tetsujin::Instrument::Guitar::Fret]
    def find_by_note(note)
      frets.find { |fret| fret.note == note }
    end
  end
end
