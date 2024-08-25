# frozen_string_literal: true

RSpec.describe Tetsujin::Instrument::Guitar::Frets do
  describe "#initialize" do
    context "正しいパラメータを渡した場合" do
      let(:note) { Tetsujin::Theory::Note.new(pitch_class: 0, octave: 4) }
      let(:string_number) { 1 }
      let(:fret_number) { 0 }
      let(:fret) do
        Tetsujin::Instrument::Guitar::Fret.new(note: note, string_number: string_number, fret_number: fret_number)
      end
      it { expect { described_class.new(frets: [fret]) }.not_to raise_error }
    end
    context "フレットが不正な場合" do
      let(:note) { Tetsujin::Theory::Note.new(pitch_class: 0, octave: 4) }
      let(:string_number) { 1 }
      let(:fret_number) { 0 }
      let(:fret) { "X" }
      it { expect { described_class.new(frets: [fret]) }.to raise_error TypeError }
    end
  end

  describe "#==" do
    context "同じフレットの場合" do
      let(:frets_1) { [
        Tetsujin::Instrument::Guitar::Fret.new(note: Tetsujin::Theory::Note.new(pitch_class: 0, octave: 4), string_number: 6, fret_number: 0),
        Tetsujin::Instrument::Guitar::Fret.new(note: Tetsujin::Theory::Note.new(pitch_class: 2, octave: 4), string_number: 6, fret_number: 2)
      ] }
      let(:frets_2) { [
        Tetsujin::Instrument::Guitar::Fret.new(note: Tetsujin::Theory::Note.new(pitch_class: 0, octave: 4), string_number: 6, fret_number: 0),
        Tetsujin::Instrument::Guitar::Fret.new(note: Tetsujin::Theory::Note.new(pitch_class: 2, octave: 4), string_number: 6, fret_number: 2)
      ] }
      it { expect(described_class.new(frets: frets_1) == described_class.new(frets: frets_2)).to be true }
    end
    context "異なるフレットの場合" do
      let(:frets_1) { [
        Tetsujin::Instrument::Guitar::Fret.new(note: Tetsujin::Theory::Note.new(pitch_class: 0, octave: 4), string_number: 6, fret_number: 0),
        Tetsujin::Instrument::Guitar::Fret.new(note: Tetsujin::Theory::Note.new(pitch_class: 2, octave: 4), string_number: 6, fret_number: 2)
      ] }
      let(:frets_2) { [
        Tetsujin::Instrument::Guitar::Fret.new(note: Tetsujin::Theory::Note.new(pitch_class: 0, octave: 4), string_number: 6, fret_number: 0),
        Tetsujin::Instrument::Guitar::Fret.new(note: Tetsujin::Theory::Note.new(pitch_class: 2, octave: 4), string_number: 6, fret_number: 4)
      ] }
      it { expect(described_class.new(frets: frets_1) == described_class.new(frets: frets_2)).to be false }
    end
  end

  describe "#play!" do
    let(:note_1) { Tetsujin::Theory::Note.new(pitch_class: 0, octave: 4) }
    let(:note_2) { Tetsujin::Theory::Note.new(pitch_class: 2, octave: 4) }
    let(:fret_1) { Tetsujin::Instrument::Guitar::Fret.new(note: note_1, string_number: 6, fret_number: 0) }
    let(:fret_2) { Tetsujin::Instrument::Guitar::Fret.new(note: note_2, string_number: 6, fret_number: 2) }
    let(:frets) { described_class.new(frets: [fret_1, fret_2]) }
    it do
      expect(fret_1).to receive(:press!)
      frets.play!(note_1)
    end
  end

  describe "#press!" do
    let(:fret_1) { Tetsujin::Instrument::Guitar::Fret.new(note: Tetsujin::Theory::Note.new(pitch_class: 0, octave: 4), string_number: 6, fret_number: 0) }
    let(:fret_2) { Tetsujin::Instrument::Guitar::Fret.new(note: Tetsujin::Theory::Note.new(pitch_class: 2, octave: 4), string_number: 6, fret_number: 2) }
    let(:frets) { described_class.new(frets: [fret_1, fret_2]) }
    it do
      expect(fret_2).to receive(:press!)
      frets.press!(2)
    end
  end

  describe "#release!" do
    let(:fret_1) { Tetsujin::Instrument::Guitar::Fret.new(note: Tetsujin::Theory::Note.new(pitch_class: 0, octave: 4), string_number: 6, fret_number: 0) }
    let(:fret_2) { Tetsujin::Instrument::Guitar::Fret.new(note: Tetsujin::Theory::Note.new(pitch_class: 2, octave: 4), string_number: 6, fret_number: 2) }
    let(:frets) { described_class.new(frets: [fret_1, fret_2]) }
    it do
      expect(fret_1).to receive(:release!)
      expect(fret_2).to receive(:release!)
      frets.release!
    end
  end

  describe "#find_by_fret_number" do
    let(:fret_1) { Tetsujin::Instrument::Guitar::Fret.new(note: Tetsujin::Theory::Note.new(pitch_class: 0, octave: 4), string_number: 6, fret_number: 0) }
    let(:fret_2) { Tetsujin::Instrument::Guitar::Fret.new(note: Tetsujin::Theory::Note.new(pitch_class: 2, octave: 4), string_number: 6, fret_number: 2) }
    let(:frets) { described_class.new(frets: [fret_1, fret_2]) }
    it { expect(frets.find_by_fret_number(2)).to eq fret_2 }
  end

  describe "#find_by_note" do
    let(:note) { Tetsujin::Theory::Note.new(pitch_class: 0, octave: 4) }
    let(:fret_1) { Tetsujin::Instrument::Guitar::Fret.new(note: note, string_number: 6, fret_number: 0) }
    let(:fret_2) { Tetsujin::Instrument::Guitar::Fret.new(note: Tetsujin::Theory::Note.new(pitch_class: 2, octave: 4), string_number: 6, fret_number: 2) }
    let(:frets) { described_class.new(frets: [fret_1, fret_2]) }
    it { expect(frets.find_by_note(note)).to eq fret_1 }
  end
end
