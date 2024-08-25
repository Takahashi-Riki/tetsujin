# frozen_string_literal: true

module Tetsujin::Theory
  class Note::Factory
    NOTE_NAME_JA_TO_PITCH_CLASS = {
      "ド" => 0,
      "ド#" => 1, "ド♯" => 1, "レb" => 1, "レ♭" => 1,
      "レ" => 2,
      "レ#" => 3, "レ♯" => 3, "ミb" => 3, "ミ♭" => 3,
      "ミ" => 4,
      "ファ" => 5,
      "ファ#" => 6, "ファ♯" => 6, "ソb" => 6, "ソ♭" => 6,
      "ソ" => 7,
      "ソ#" => 8, "ソ♯" => 8, "ラb" => 8, "ラ♭" => 8,
      "ラ" => 9,
      "ラ#" => 10, "ラ♯" => 10, "シb" => 10, "シ♭" => 10,
      "シ" => 11
    }.freeze
    NOTE_NAME_EN_TO_PITCH_CLASS = {
      "C" => 0,
      "C#" => 1, "C♯" => 1, "Db" => 1, "D♭" => 1,
      "D" => 2,
      "D#" => 3, "D♯" => 3, "Eb" => 3, "E♭" => 3,
      "E" => 4,
      "F" => 5,
      "F#" => 6, "F♯" => 6, "Gb" => 6, "G♭" => 6,
      "G" => 7,
      "G#" => 8, "G♯" => 8, "Ab" => 8, "A♭" => 8,
      "A" => 9,
      "A#" => 10, "A♯" => 10, "Bb" => 10, "B♭" => 10,
      "B" => 11
    }.freeze
    NOTE_NAME_ALIAS_TO_PITCH_CLASS = NOTE_NAME_JA_TO_PITCH_CLASS.merge(NOTE_NAME_EN_TO_PITCH_CLASS).freeze
    private_constant :NOTE_NAME_JA_TO_PITCH_CLASS, :NOTE_NAME_EN_TO_PITCH_CLASS, :NOTE_NAME_ALIAS_TO_PITCH_CLASS

    # @param name [String | Symbol] 音名
    # @param octave [Integer] オクターブ
    # @return [Tetsujin::Theory::Note]
    def self.create_from_name(name:, octave:)
      raise TypeError unless name.is_a?(String) || name.is_a?(Symbol)
      pitch_class = search_pitch_class(name.to_s)
      raise ArgumentError unless pitch_class
      Tetsujin::Theory::Note.new(pitch_class: pitch_class, octave: octave)
    end

    private

    def self.search_pitch_class(name)
      note_name_alias_to_pitch_class[name]
    end

    def self.note_name_alias_to_pitch_class
      NOTE_NAME_ALIAS_TO_PITCH_CLASS
    end
  end
end
