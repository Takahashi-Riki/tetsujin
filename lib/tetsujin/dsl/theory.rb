# frozen_string_literal: true

module Tetsujin
  module DSL
    module Theory
      # @param name [String] 音名
      # @param octave [Integer] オクターブ
      def note(name, octave)
        Tetsujin::Theory::Note::Factory.create_from_name(name: name, octave: octave)
      end

      # @param root [Tetsujin::Theory::Note] ルート音
      # @param pattern [String | Symbol] スケールのパターン
      def scale(root, pattern)
        Tetsujin::Theory::Scale.new(root: root, pattern: pattern.to_sym)
      end
    end
  end
end
