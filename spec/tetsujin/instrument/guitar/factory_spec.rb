# frozen_string_literal: true

RSpec.describe Tetsujin::Instrument::Guitar::Factory do
  describe ".create" do
    let(:tuning_e) {  Tetsujin::Theory::Note.new(pitch_class:  4, octave: 2) }
    let(:tuning_a) {  Tetsujin::Theory::Note.new(pitch_class:  9, octave: 2) }
    let(:tuning_d) {  Tetsujin::Theory::Note.new(pitch_class:  2, octave: 3) }
    let(:tuning_g) {  Tetsujin::Theory::Note.new(pitch_class:  7, octave: 3) }
    let(:tuning_b) {  Tetsujin::Theory::Note.new(pitch_class: 11, octave: 3) }
    let(:tuning_e2) { Tetsujin::Theory::Note.new(pitch_class:  4, octave: 4) }
    let(:tunings) { [tuning_e, tuning_a, tuning_d, tuning_g, tuning_b, tuning_e2] }
    let(:fretboard_length) { 12 }
    let(:expected_guitar) {
      Tetsujin::Instrument::Guitar.new(strings: [
        Tetsujin::Instrument::Guitar::String.new(string_number: 6, tuning:  tuning_e, fretboard_length: fretboard_length),
        Tetsujin::Instrument::Guitar::String.new(string_number: 5, tuning:  tuning_a, fretboard_length: fretboard_length),
        Tetsujin::Instrument::Guitar::String.new(string_number: 4, tuning:  tuning_d, fretboard_length: fretboard_length),
        Tetsujin::Instrument::Guitar::String.new(string_number: 3, tuning:  tuning_g, fretboard_length: fretboard_length),
        Tetsujin::Instrument::Guitar::String.new(string_number: 2, tuning:  tuning_b, fretboard_length: fretboard_length),
        Tetsujin::Instrument::Guitar::String.new(string_number: 1, tuning: tuning_e2, fretboard_length: fretboard_length)
      ])
    }
    it { expect(described_class.create(tunings: tunings, fretboard_length: fretboard_length)).to eq expected_guitar }
  end
end
