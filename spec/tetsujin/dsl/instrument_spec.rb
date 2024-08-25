# frozen_string_literal: true

RSpec.describe Tetsujin::DSL::Instrument do
  describe "#regular_tuning_guitar" do
    let(:dummy_class) { Class.new { include Tetsujin::DSL::Instrument } }

    let(:tuning_e) {  Tetsujin::Theory::Note.new(pitch_class:  4, octave: 2) }
    let(:tuning_a) {  Tetsujin::Theory::Note.new(pitch_class:  9, octave: 2) }
    let(:tuning_d) {  Tetsujin::Theory::Note.new(pitch_class:  2, octave: 3) }
    let(:tuning_g) {  Tetsujin::Theory::Note.new(pitch_class:  7, octave: 3) }
    let(:tuning_b) {  Tetsujin::Theory::Note.new(pitch_class: 11, octave: 3) }
    let(:tuning_e2) { Tetsujin::Theory::Note.new(pitch_class:  4, octave: 4) }
    let(:tunings) { [tuning_e, tuning_a, tuning_d, tuning_g, tuning_b, tuning_e2] }
    let(:fretboard_length) { 12 }
    it do
      expect(Tetsujin::Instrument::Guitar::Factory).to receive(:create).with(tunings: tunings, fretboard_length: fretboard_length)
      dummy_class.new.regular_tuning_guitar(fretboard_length: fretboard_length)
    end
  end

  describe "#guitar" do
    let(:dummy_class) { Class.new { include Tetsujin::DSL::Instrument } }

    let(:tuning_e) {  Tetsujin::Theory::Note.new(pitch_class:  4, octave: 2) }
    let(:tuning_a) {  Tetsujin::Theory::Note.new(pitch_class:  9, octave: 2) }
    let(:tuning_d) {  Tetsujin::Theory::Note.new(pitch_class:  2, octave: 3) }
    let(:tuning_g) {  Tetsujin::Theory::Note.new(pitch_class:  7, octave: 3) }
    let(:tuning_b) {  Tetsujin::Theory::Note.new(pitch_class: 11, octave: 3) }
    let(:tuning_e2) { Tetsujin::Theory::Note.new(pitch_class:  4, octave: 4) }
    let(:tunings) { [tuning_e, tuning_a, tuning_d, tuning_g, tuning_b, tuning_e2] }
    let(:fretboard_length) { 12 }
    it do
      expect(Tetsujin::Instrument::Guitar::Factory).to receive(:create).with(tunings: tunings, fretboard_length: fretboard_length)
      dummy_class.new.guitar(tunings: tunings, fretboard_length: fretboard_length)
    end
  end

  describe "#display_guitar" do
    let(:dummy_class) { Class.new { include Tetsujin::DSL::Instrument } }

    let(:tuning_e) {  Tetsujin::Theory::Note.new(pitch_class:  4, octave: 2) }
    let(:tuning_a) {  Tetsujin::Theory::Note.new(pitch_class:  9, octave: 2) }
    let(:tuning_d) {  Tetsujin::Theory::Note.new(pitch_class:  2, octave: 3) }
    let(:tuning_g) {  Tetsujin::Theory::Note.new(pitch_class:  7, octave: 3) }
    let(:tuning_b) {  Tetsujin::Theory::Note.new(pitch_class: 11, octave: 3) }
    let(:tuning_e2) { Tetsujin::Theory::Note.new(pitch_class:  4, octave: 4) }
    let(:tunings) { [tuning_e, tuning_a, tuning_d, tuning_g, tuning_b, tuning_e2] }
    let(:fretboard_length) { 12 }
    let(:strings) { [
      Tetsujin::Instrument::Guitar::String.new(string_number: 6, tuning: tuning_e, fretboard_length: fretboard_length),
      Tetsujin::Instrument::Guitar::String.new(string_number: 5, tuning: tuning_a, fretboard_length: fretboard_length),
      Tetsujin::Instrument::Guitar::String.new(string_number: 4, tuning: tuning_d, fretboard_length: fretboard_length),
      Tetsujin::Instrument::Guitar::String.new(string_number: 3, tuning: tuning_g, fretboard_length: fretboard_length),
      Tetsujin::Instrument::Guitar::String.new(string_number: 2, tuning: tuning_b, fretboard_length: fretboard_length),
      Tetsujin::Instrument::Guitar::String.new(string_number: 1, tuning: tuning_e2, fretboard_length: fretboard_length)
    ] }
    let(:guitar) { Tetsujin::Instrument::Guitar.new(strings: strings) }
    let(:displayer) { Tetsujin::Instrument::Guitar::Displayer.new }
    before do
      allow_any_instance_of(Tetsujin::Instrument::Guitar::Displayer).to receive(:print_fretboard).with(guitar).and_return("dummy fretboard")
    end
    it { expect(dummy_class.new.display_guitar(guitar)).to eq guitar.print_fretboard(displayer) }
  end
end
