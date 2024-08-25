# frozen_string_literal: true

RSpec.describe Tetsujin::Instrument::Guitar do
  describe "#initialize" do
    context "正しいパラメータを渡した場合" do
      let(:tuning_e) {  Tetsujin::Theory::Note.new(pitch_class:  4, octave: 2) }
      let(:tuning_a) {  Tetsujin::Theory::Note.new(pitch_class:  9, octave: 2) }
      let(:tuning_d) {  Tetsujin::Theory::Note.new(pitch_class:  2, octave: 3) }
      let(:tuning_g) {  Tetsujin::Theory::Note.new(pitch_class:  7, octave: 3) }
      let(:tuning_b) {  Tetsujin::Theory::Note.new(pitch_class: 11, octave: 3) }
      let(:tuning_e2) { Tetsujin::Theory::Note.new(pitch_class:  4, octave: 4) }
      let(:fretboard_length) { 12 }
      let(:strings) { [
        Tetsujin::Instrument::Guitar::String.new(string_number: 6, tuning:  tuning_e, fretboard_length: fretboard_length),
        Tetsujin::Instrument::Guitar::String.new(string_number: 5, tuning:  tuning_a, fretboard_length: fretboard_length),
        Tetsujin::Instrument::Guitar::String.new(string_number: 4, tuning:  tuning_d, fretboard_length: fretboard_length),
        Tetsujin::Instrument::Guitar::String.new(string_number: 3, tuning:  tuning_g, fretboard_length: fretboard_length),
        Tetsujin::Instrument::Guitar::String.new(string_number: 2, tuning:  tuning_b, fretboard_length: fretboard_length),
        Tetsujin::Instrument::Guitar::String.new(string_number: 1, tuning: tuning_e2, fretboard_length: fretboard_length)
      ] }
      it { expect { described_class.new(strings: strings) }.not_to raise_error }
    end
    context "弦が配列でない場合" do
      let(:strings) { "X" }
      it { expect { described_class.new(strings: strings) }.to raise_error TypeError }
    end
    context "弦が不正な場合" do
      let(:strings) { ["X"] }
      it { expect { described_class.new(strings: strings) }.to raise_error TypeError }
    end
  end

  describe "#play!" do
    let(:string_1) { Tetsujin::Instrument::Guitar::String.new(string_number: 1, tuning: Tetsujin::Theory::Note.new(pitch_class: 0, octave: 0), fretboard_length: 12) }
    let(:string_2) { Tetsujin::Instrument::Guitar::String.new(string_number: 2, tuning: Tetsujin::Theory::Note.new(pitch_class: 0, octave: 0), fretboard_length: 12) }
    let(:guitar) { described_class.new(strings: [string_1, string_2]) }
    let(:notes) { [Tetsujin::Theory::Note.new(pitch_class: 0, octave: 4), Tetsujin::Theory::Note.new(pitch_class: 2, octave: 4)] }
    it do
      expect(string_1).to receive(:play!).with(notes)
      expect(string_2).to receive(:play!).with(notes)
      guitar.play!(notes)
    end
  end

  describe "#press!" do
    let(:string_1) { Tetsujin::Instrument::Guitar::String.new(string_number: 1, tuning: Tetsujin::Theory::Note.new(pitch_class: 0, octave: 0), fretboard_length: 12) }
    let(:string_2) { Tetsujin::Instrument::Guitar::String.new(string_number: 2, tuning: Tetsujin::Theory::Note.new(pitch_class: 0, octave: 0), fretboard_length: 12) }
    let(:guitar) { described_class.new(strings: [string_1, string_2]) }
    before do
      allow(guitar).to receive(:find_string).with(1).and_return(string_1)
    end
    it do
      expect(string_1).to receive(:press!).with(2)
      guitar.press!(1, 2)
    end
  end

  describe "#release!" do
    let(:string_1) { Tetsujin::Instrument::Guitar::String.new(string_number: 1, tuning: Tetsujin::Theory::Note.new(pitch_class: 0, octave: 0), fretboard_length: 12) }
    let(:string_2) { Tetsujin::Instrument::Guitar::String.new(string_number: 2, tuning: Tetsujin::Theory::Note.new(pitch_class: 0, octave: 0), fretboard_length: 12) }
    let(:guitar) { described_class.new(strings: [string_1, string_2]) }
    it do
      expect(string_1).to receive(:release!)
      expect(string_2).to receive(:release!)
      guitar.release!
    end
  end

  describe "#[]" do
    let(:string_1) { Tetsujin::Instrument::Guitar::String.new(string_number: 1, tuning: Tetsujin::Theory::Note.new(pitch_class: 0, octave: 0), fretboard_length: 12) }
    let(:string_2) { Tetsujin::Instrument::Guitar::String.new(string_number: 2, tuning: Tetsujin::Theory::Note.new(pitch_class: 0, octave: 0), fretboard_length: 12) }
    let(:guitar) { described_class.new(strings: [string_1, string_2]) }
    it { expect(guitar[1]).to eq string_1 }
  end

  describe "#fretboard_length" do
    let(:string_1) { Tetsujin::Instrument::Guitar::String.new(string_number: 1, tuning: Tetsujin::Theory::Note.new(pitch_class: 0, octave: 0), fretboard_length: 12) }
    let(:string_2) { Tetsujin::Instrument::Guitar::String.new(string_number: 2, tuning: Tetsujin::Theory::Note.new(pitch_class: 0, octave: 0), fretboard_length: 22) }
    let(:guitar) { described_class.new(strings: [string_1, string_2]) }
    it { expect(guitar.fretboard_length).to eq 22 }
  end

  describe "#print_fretboard" do
    let(:string_1) { Tetsujin::Instrument::Guitar::String.new(string_number: 1, tuning: Tetsujin::Theory::Note.new(pitch_class: 0, octave: 0), fretboard_length: 12) }
    let(:string_2) { Tetsujin::Instrument::Guitar::String.new(string_number: 2, tuning: Tetsujin::Theory::Note.new(pitch_class: 0, octave: 0), fretboard_length: 12) }
    let(:guitar) { described_class.new(strings: [string_1, string_2]) }
    let(:displayer) { Tetsujin::Instrument::Guitar::Displayer.new }
    it do
      expect(displayer).to receive(:print_fretboard).with(guitar)
      guitar.print_fretboard(displayer)
    end
  end

  describe "#==" do
    context "全ての弦が同じ場合" do
      let(:string_1_1) { Tetsujin::Instrument::Guitar::String.new(string_number: 1, tuning: Tetsujin::Theory::Note.new(pitch_class: 0, octave: 0), fretboard_length: 12) }
      let(:string_1_2) { Tetsujin::Instrument::Guitar::String.new(string_number: 2, tuning: Tetsujin::Theory::Note.new(pitch_class: 2, octave: 0), fretboard_length: 22) }
      let(:string_2_1) { Tetsujin::Instrument::Guitar::String.new(string_number: 1, tuning: Tetsujin::Theory::Note.new(pitch_class: 0, octave: 0), fretboard_length: 12) }
      let(:string_2_2) { Tetsujin::Instrument::Guitar::String.new(string_number: 2, tuning: Tetsujin::Theory::Note.new(pitch_class: 2, octave: 0), fretboard_length: 22) }
      let(:guitar_1) { described_class.new(strings: [string_1_1, string_1_2]) }
      let(:guitar_2) { described_class.new(strings: [string_2_2, string_2_1]) }
      it { expect(guitar_1 == guitar_2).to be true }
    end
    context "一部の弦が異なる場合" do
      let(:string_1_1) { Tetsujin::Instrument::Guitar::String.new(string_number: 1, tuning: Tetsujin::Theory::Note.new(pitch_class: 0, octave: 0), fretboard_length: 12) }
      let(:string_1_2) { Tetsujin::Instrument::Guitar::String.new(string_number: 2, tuning: Tetsujin::Theory::Note.new(pitch_class: 2, octave: 0), fretboard_length: 22) }
      let(:string_2_1) { Tetsujin::Instrument::Guitar::String.new(string_number: 1, tuning: Tetsujin::Theory::Note.new(pitch_class: 0, octave: 0), fretboard_length: 12) }
      let(:string_2_2) { Tetsujin::Instrument::Guitar::String.new(string_number: 2, tuning: Tetsujin::Theory::Note.new(pitch_class: 4, octave: 0), fretboard_length: 22) }
      let(:guitar_1) { described_class.new(strings: [string_1_1, string_1_2]) }
      let(:guitar_2) { described_class.new(strings: [string_2_1, string_2_2]) }
      it { expect(guitar_1 == guitar_2).to be false }
    end
  end
end
