# frozen_string_literal: true

module Tetsujin::Theory
  class Scale < Notes
    SCALE_PATTERNS = {
      major:            [2, 2, 1, 2, 2, 2, 1],
      minor:            [2, 1, 2, 2, 1, 2, 2],
      harmonic_minor:   [2, 1, 2, 2, 1, 3, 1],
      melodic_minor:    [2, 1, 2, 2, 2, 2, 1],
      dorian:           [2, 1, 2, 2, 2, 1, 2],
      phrygian:         [1, 2, 2, 2, 1, 2, 2],
      lydian:           [2, 2, 2, 1, 2, 2, 1],
      mixolydian:       [2, 2, 1, 2, 2, 1, 2],
      aeolian:          [2, 1, 2, 2, 1, 2, 2],
      locrian:          [1, 2, 2, 1, 2, 2, 2],
      whole_tone:       [2, 2, 2, 2, 2, 2],
      chromatic:        [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
      blues:            [3, 2, 1, 1, 3, 2],
      pentatonic_major: [2, 2, 3, 2, 3],
      pentatonic_minor: [3, 2, 2, 3, 2],
      diminished:       [2, 1, 2, 1, 2, 1, 2, 1]
    }.freeze

    # @param root [Tetsujin::Theory::Note] スケールのルート音
    # @param pattern [Symbol] スケールの構成パターン
    def initialize(root:, pattern: :major)
      raise TypeError unless root.is_a?(Tetsujin::Theory::Note)
      raise TypeError unless pattern.is_a?(Symbol)
      raise ArgumentError unless SCALE_PATTERNS.key?(pattern)

      @root = root
      @pattern = SCALE_PATTERNS[pattern]
    end

    # @return [Array<Tetsujin::Theory::Note>] スケールの音階
    def notes
      @_notes ||= generate_scale
    end

    private

    attr_reader :root, :pattern

    # @return [Array<Tetsujin::Theory::Note>] スケールの音階
    def generate_scale
      notes = [root]
      pattern.each do |interval|
        notes << notes.last.add(Tetsujin::Theory::Interval.new(value: interval))
      end
      notes
    end
  end
end
