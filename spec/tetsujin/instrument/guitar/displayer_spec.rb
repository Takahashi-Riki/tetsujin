# frozen_string_literal: true

RSpec.describe Tetsujin::Instrument::Guitar::Displayer do
  describe "#print_fretboard" do
    let(:tuning_e) {  Tetsujin::Theory::Note.new(pitch_class:  4, octave: 2) }
    let(:tuning_a) {  Tetsujin::Theory::Note.new(pitch_class:  9, octave: 2) }
    let(:tuning_d) {  Tetsujin::Theory::Note.new(pitch_class:  2, octave: 3) }
    let(:tuning_g) {  Tetsujin::Theory::Note.new(pitch_class:  7, octave: 3) }
    let(:tuning_b) {  Tetsujin::Theory::Note.new(pitch_class: 11, octave: 3) }
    let(:tuning_e2) { Tetsujin::Theory::Note.new(pitch_class:  4, octave: 4) }
    let(:tunings) { [tuning_e, tuning_a, tuning_d, tuning_g, tuning_b, tuning_e2] }
    let(:fretboard_length) { 12 }
    let(:strings) { [
      Tetsujin::Instrument::Guitar::String.new(string_number: 6, tuning:  tuning_e, fretboard_length: fretboard_length),
      Tetsujin::Instrument::Guitar::String.new(string_number: 5, tuning:  tuning_a, fretboard_length: fretboard_length),
      Tetsujin::Instrument::Guitar::String.new(string_number: 4, tuning:  tuning_d, fretboard_length: fretboard_length),
      Tetsujin::Instrument::Guitar::String.new(string_number: 3, tuning:  tuning_g, fretboard_length: fretboard_length),
      Tetsujin::Instrument::Guitar::String.new(string_number: 2, tuning:  tuning_b, fretboard_length: fretboard_length),
      Tetsujin::Instrument::Guitar::String.new(string_number: 1, tuning: tuning_e2, fretboard_length: fretboard_length)
    ] }
    let(:guitar) { Tetsujin::Instrument::Guitar.new(strings: strings) }
    let(:displayer) { described_class.new }
    let(:c_major_scale) { Tetsujin::Theory::Scale.new(root: Tetsujin::Theory::Note.new(pitch_class: 0, octave: 4), pattern: :major) }
    let(:expected_fretboard) {
    <<-FRETBOARD
 1 :      E4      F4 -------      G4 -------      A4 -------      B4      C5 ------- ------- ------- -------
 2 : -------      C4 -------      D4 -------      E4      F4 -------      G4 -------      A4 -------      B4
 3 : ------- ------- ------- ------- -------      C4 -------      D4 -------      E4      F4 -------      G4
 4 : ------- ------- ------- ------- ------- ------- ------- ------- ------- -------      C4 -------      D4
 5 : ------- ------- ------- ------- ------- ------- ------- ------- ------- ------- ------- ------- -------
 6 : ------- ------- ------- ------- ------- ------- ------- ------- ------- ------- ------- ------- -------
   :       0       1       2       3       4       5       6       7       8       9      10      11      12
      FRETBOARD
    }
    before do
      guitar.play!(c_major_scale)
    end
    it { expect{ displayer.print_fretboard(guitar) }.to output(expected_fretboard).to_stdout }
  end
end
