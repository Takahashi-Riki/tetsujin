# frozen_string_literal: true

RSpec.describe Tetsujin::Theory::Notes do
  describe "#initialize" do
    context "正しい音の配列を渡した場合" do
      let(:notes) { [Tetsujin::Theory::Note.new(pitch_class: 0, octave: 4), Tetsujin::Theory::Note.new(pitch_class: 2, octave: 4)] }
      it { expect { described_class.new(notes: notes) }.not_to raise_error }
    end
    context "配列以外を渡した場合" do
      let(:notes) { Tetsujin::Theory::Note.new(pitch_class: 0, octave: 4) }
      it { expect { described_class.new(notes: notes) }.to raise_error TypeError }
    end
    context "音が不正な場合" do
      let(:notes) { ["C", "D"] }
      it { expect { described_class.new(notes: notes) }.to raise_error ArgumentError }
    end
  end

  describe "#==" do
    context "同じ音の場合" do
      let(:notes1) { described_class.new(notes: [Tetsujin::Theory::Note.new(pitch_class: 0, octave: 4), Tetsujin::Theory::Note.new(pitch_class: 2, octave: 4)]) }
      let(:notes2) { described_class.new(notes: [Tetsujin::Theory::Note.new(pitch_class: 2, octave: 4), Tetsujin::Theory::Note.new(pitch_class: 0, octave: 4)]) }
      it { expect(notes1 == notes2).to eq true }
    end
    context "違う音の場合" do
      let(:notes1) { described_class.new(notes: [Tetsujin::Theory::Note.new(pitch_class: 0, octave: 4), Tetsujin::Theory::Note.new(pitch_class: 2, octave: 4)]) }
      let(:notes2) { described_class.new(notes: [Tetsujin::Theory::Note.new(pitch_class: 0, octave: 4), Tetsujin::Theory::Note.new(pitch_class: 3, octave: 4)]) }
      it { expect(notes1 == notes2).to eq false }
    end
  end

  describe "#+" do
    let(:notes1) { described_class.new(notes: [Tetsujin::Theory::Note.new(pitch_class: 0, octave: 4), Tetsujin::Theory::Note.new(pitch_class: 2, octave: 4)]) }
    let(:notes2) { described_class.new(notes: [Tetsujin::Theory::Note.new(pitch_class: 0, octave: 4), Tetsujin::Theory::Note.new(pitch_class: 3, octave: 4)]) }
    let(:expected) { described_class.new(notes: [Tetsujin::Theory::Note.new(pitch_class: 0, octave: 4), Tetsujin::Theory::Note.new(pitch_class: 2, octave: 4), Tetsujin::Theory::Note.new(pitch_class: 3, octave: 4)]) }
    it { expect(notes1 + notes2).to eq expected }
  end
end
