# frozen_string_literal: true
require "forwardable"

module Tetsujin::Theory
  class Notes
    extend Forwardable
    def_delegators :notes, :each, :map

    attr_reader :notes

    # @param notes [Array<Tetsujin::Theory::Note>] 音の配列
    def initialize(notes:)
      raise TypeError unless notes.is_a?(Array)
      raise ArgumentError unless notes.all? { |note| note.is_a?(Tetsujin::Theory::Note) }
      @notes = notes
    end

    # @param other [Tetsujin::Theory::Notes]
    # @return [Boolean] 同じ音を持つかどうか
    def ==(other)
      self_sorted = notes.sort do |a, b|
        [a.octave, a.pitch_class] <=> [b.octave, b.pitch_class]
      end
      other_sorted = other.notes.sort do |a, b|
        [a.octave, a.pitch_class] <=> [b.octave, b.pitch_class]
      end
      self_sorted == other_sorted
    end

    # @param other [Tetsujin::Theory::Notes]
    # @return [Tetsujin::Theory::Notes] 2つの音の和集合
    def +(other)
      new_notes = (notes + other.notes).uniq.sort
      Tetsujin::Theory::Notes.new(notes: new_notes)
    end
  end
end
