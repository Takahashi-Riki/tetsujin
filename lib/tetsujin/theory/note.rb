# frozen_string_literal: true

module Tetsujin::Theory
  class Note
    attr_reader :pitch_class, :octave

    PITCH_CLASS_TO_NOTE_NAME = {
      0 => ["C"],
      1 => ["C♯", "D♭"],
      2 => ["D"],
      3 => ["D♯", "E♭"],
      4 => ["E"],
      5 => ["F"],
      6 => ["F♯", "G♭"],
      7 => ["G"],
      8 => ["G♯", "A♭"],
      9 => ["A"],
      10 => ["A♯", "B♭"],
      11 => ["B"]
    }.freeze
    NOTES_IN_OCTAVE = 12
    private_constant :PITCH_CLASS_TO_NOTE_NAME, :NOTES_IN_OCTAVE

    # @param pitch_class [Integer] ピッチクラス
    # @param octave [Integer] オクターブ
    def initialize(pitch_class:, octave: 4)
      raise TypeError unless pitch_class.is_a?(Integer)
      raise TypeError unless octave.is_a?(Integer)
      raise ArgumentError unless PITCH_CLASS_TO_NOTE_NAME.key?(pitch_class)

      @pitch_class = pitch_class
      @octave = octave
    end

    # @return [String] 音名とオクターブを結合した文字列 (例: "G♯4/A♭4")
    def to_s
      note_names = PITCH_CLASS_TO_NOTE_NAME[pitch_class]
      note_names.map { |note_name| "#{note_name}#{octave}" }.join("/")
    end

    # @param interval [Tetsujin::Theory::Interval] 移動する音程
    # @return [Tetsujin::Theory::Note] 移動後の音
    def add(interval)
      added_octaves, new_pitch_class = (pitch_class + interval.value).divmod(notes_in_octave)
      self.class.new(pitch_class: new_pitch_class, octave: octave + added_octaves)
    end

    # @param interval [Tetsujin::Theory::Interval] 移動する音程
    # @return [Tetsujin::Theory::Note] 移動後の音
    def subtract(interval)
      subtracted_octaves, new_pitch_class = (pitch_class - interval.value).divmod(notes_in_octave)
      self.class.new(pitch_class: new_pitch_class, octave: octave + subtracted_octaves)
    end

    # @param other [Tetsujin::Theory::Note] 比較対象の音
    # @return [Tetsujin::Theory::Interval] 2つの音の音程
    def diff(other)
      pitch_diff = (other.octave - octave) * notes_in_octave + other.pitch_class - pitch_class
      Tetsujin::Theory::Interval.new(value: pitch_diff)
    end

    # @param other [Tetsujin::Theory::Note] 比較対象の音
    # @return [Boolean] 音名とオクターブが一致しているか
    def ==(other)
      return false unless other.is_a?(self.class)
      pitch_class == other.pitch_class && octave == other.octave
    end
    alias eql? ==

    # @return [Integer] ハッシュ値
    def hash
      [pitch_class, octave].hash
    end

    # @param other [Tetsujin::Theory::Note] 比較対象の音
    # @return [Integer] 音名とオクターブの比較結果
    def <=>(other)
      return nil unless other.is_a?(self.class)
      octave == other.octave ? pitch_class <=> other.pitch_class : octave <=> other.octave
    end

    private

    # @return [Integer] 1オクターブあたりの音数
    def notes_in_octave
      NOTES_IN_OCTAVE
    end
  end
end
