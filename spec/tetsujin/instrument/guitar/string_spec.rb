# frozen_string_literal: true

RSpec.describe Tetsujin::Instrument::Guitar::String do
  describe "#initialize" do
    context "正しいパラメータを渡した場合" do
      let(:tuning) { Tetsujin::Theory::Note.new(pitch_class: 0, octave: 4) }
      let(:string_number) { 1 }
      let(:fretboard_length) { 22 }
      it { expect { described_class.new(tuning: tuning, string_number: string_number, fretboard_length: fretboard_length) }.not_to raise_error}
    end
    context "音名が不正な場合" do
      let(:tuning) { "X" }
      let(:string_number) { 1 }
      let(:fretboard_length) { 22 }
      it { expect { described_class.new(tuning: tuning, string_number: string_number, fretboard_length: fretboard_length) }.to raise_error TypeError}
    end
    context "弦番号が不正な場合" do
      let(:tuning) { Tetsujin::Theory::Note.new(pitch_class: 0, octave: 4) }
      let(:string_number) { "X" }
      let(:fretboard_length) { 22 }
      it { expect { described_class.new(tuning: tuning, string_number: string_number, fretboard_length: fretboard_length) }.to raise_error TypeError}
    end
    context "フレット数が不正な場合" do
      let(:tuning) { Tetsujin::Theory::Note.new(pitch_class: 0, octave: 4) }
      let(:string_number) { 1 }
      let(:fretboard_length) { "X" }
      it { expect { described_class.new(tuning: tuning, string_number: string_number, fretboard_length: fretboard_length) }.to raise_error TypeError}
    end
  end

  describe "#frets" do
    let(:tuning) { Tetsujin::Theory::Note.new(pitch_class: 0, octave: 4) }
    let(:note_at_fret_1) { Tetsujin::Theory::Note.new(pitch_class: 1, octave: 4) }
    let(:note_at_fret_2) { Tetsujin::Theory::Note.new(pitch_class: 2, octave: 4) }
    let(:note_at_fret_3) { Tetsujin::Theory::Note.new(pitch_class: 3, octave: 4) }
    let(:note_at_fret_4) { Tetsujin::Theory::Note.new(pitch_class: 4, octave: 4) }
    let(:note_at_fret_5) { Tetsujin::Theory::Note.new(pitch_class: 5, octave: 4) }
    let(:string_number) { 1 }
    let(:fretboard_length) { 5 }
    let(:string) { described_class.new(tuning: tuning, string_number: string_number, fretboard_length: fretboard_length) }
    it do
      expect(string[0].note).to eq tuning
      expect(string[1].note).to eq note_at_fret_1
      expect(string[2].note).to eq note_at_fret_2
      expect(string[3].note).to eq note_at_fret_3
      expect(string[4].note).to eq note_at_fret_4
      expect(string[5].note).to eq note_at_fret_5
    end
  end

  describe "#[]" do
    let(:tuning) { Tetsujin::Theory::Note.new(pitch_class: 0, octave: 4) }
    let(:note_at_fret_1) { Tetsujin::Theory::Note.new(pitch_class: 1, octave: 4) }
    let(:string_number) { 1 }
    let(:fretboard_length) { 5 }
    let(:string) { described_class.new(tuning: tuning, string_number: string_number, fretboard_length: fretboard_length) }
    it { expect(string[1].note).to eq note_at_fret_1 }
  end

  describe "#play!" do
    let(:tuning) { Tetsujin::Theory::Note.new(pitch_class: 0, octave: 4) }
    let(:string_number) { 1 }
    let(:fretboard_length) { 5 }
    let(:string) { described_class.new(tuning: tuning, string_number: string_number, fretboard_length: fretboard_length) }
    context "Array<Tetsujin::Theory::Note> を渡した場合" do
      let(:notes) { [Tetsujin::Theory::Note.new(pitch_class: 0, octave: 4), Tetsujin::Theory::Note.new(pitch_class: 2, octave: 4)] }
      it do
        expect(string.frets).to receive(:play!).with(notes[0])
        expect(string.frets).to receive(:play!).with(notes[1])
        string.play!(notes)
      end
    end
    context "Tetsujin::Theory::Scale を渡した場合" do
      let(:scale) { Tetsujin::Theory::Scale.new(root: Tetsujin::Theory::Note.new(pitch_class: 0, octave: 4), pattern: :major) }
      it do
        expect(string.frets).to receive(:play!).with(scale.notes[0])
        expect(string.frets).to receive(:play!).with(scale.notes[1])
        expect(string.frets).to receive(:play!).with(scale.notes[2])
        expect(string.frets).to receive(:play!).with(scale.notes[3])
        expect(string.frets).to receive(:play!).with(scale.notes[4])
        expect(string.frets).to receive(:play!).with(scale.notes[5])
        expect(string.frets).to receive(:play!).with(scale.notes[6])
        expect(string.frets).to receive(:play!).with(scale.notes[7])
        string.play!(scale)
      end
    end
  end

  describe "#press!" do
    let(:tuning) { Tetsujin::Theory::Note.new(pitch_class: 0, octave: 4) }
    let(:string_number) { 1 }
    let(:fretboard_length) { 5 }
    let(:string) { described_class.new(tuning: tuning, string_number: string_number, fretboard_length: fretboard_length) }
    it do
      expect(string.frets).to receive(:press!).with(1)
      string.press!(1)
    end
  end

  describe "#release!" do
    let(:tuning) { Tetsujin::Theory::Note.new(pitch_class: 0, octave: 4) }
    let(:string_number) { 1 }
    let(:fretboard_length) { 5 }
    let(:string) { described_class.new(tuning: tuning, string_number: string_number, fretboard_length: fretboard_length) }
    it do
      expect(string.frets).to receive(:release!)
      string.release!
    end
  end
end
