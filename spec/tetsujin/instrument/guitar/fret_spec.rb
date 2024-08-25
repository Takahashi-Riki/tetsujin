# frozen_string_literal: true

RSpec.describe Tetsujin::Instrument::Guitar::Fret do
  describe "#initialize" do
    context "正しいパラメータを渡した場合" do
      let(:note) { Tetsujin::Theory::Note.new(pitch_class: 0, octave: 4) }
      let(:string_number) { 1 }
      let(:fret_number) { 0 }
      it { expect { described_class.new(note: note, string_number: string_number, fret_number: fret_number) }.not_to raise_error }
    end
    context "音名が不正な場合" do
      let(:note) { "X" }
      let(:string_number) { 1 }
      let(:fret_number) { 0 }
      it { expect { described_class.new(note: note, string_number: string_number, fret_number: fret_number) }.to raise_error TypeError }
    end
    context "弦番号が不正な場合" do
      let(:note) { Tetsujin::Theory::Note.new(pitch_class: 0, octave: 4) }
      let(:string_number) { "1" }
      let(:fret_number) { 0 }
      it { expect { described_class.new(note: note, string_number: string_number, fret_number: fret_number) }.to raise_error TypeError }
    end
    context "フレット番号が不正な場合" do
      let(:note) { Tetsujin::Theory::Note.new(pitch_class: 0, octave: 4) }
      let(:string_number) { 1 }
      let(:fret_number) { "0" }
      it { expect { described_class.new(note: note, string_number: string_number, fret_number: fret_number) }.to raise_error TypeError }
    end
  end

  describe "#==" do
    let(:fret_1) { described_class.new(note: note_1, string_number: string_number_1, fret_number: fret_number_1) }
    let(:fret_2) { described_class.new(note: note_2, string_number: string_number_2, fret_number: fret_number_2) }
    context "同じ音、弦、フレットの場合" do
      let(:note_1) { Tetsujin::Theory::Note.new(pitch_class: 0, octave: 4) }
      let(:note_2) { Tetsujin::Theory::Note.new(pitch_class: 0, octave: 4) }
      let(:string_number_1) { 1 }
      let(:string_number_2) { 1 }
      let(:fret_number_1) { 0 }
      let(:fret_number_2) { 0 }
      it { expect(fret_1 == fret_2).to be true }
    end
    context "異なる音の場合" do
      let(:note_1) { Tetsujin::Theory::Note.new(pitch_class: 0, octave: 4) }
      let(:note_2) { Tetsujin::Theory::Note.new(pitch_class: 2, octave: 4) }
      let(:string_number_1) { 1 }
      let(:string_number_2) { 1 }
      let(:fret_number_1) { 0 }
      let(:fret_number_2) { 0 }
      it { expect(fret_1 == fret_2).to be false }
    end
    context "異なる弦の場合" do
      let(:note_1) { Tetsujin::Theory::Note.new(pitch_class: 0, octave: 4) }
      let(:note_2) { Tetsujin::Theory::Note.new(pitch_class: 0, octave: 4) }
      let(:string_number_1) { 1 }
      let(:string_number_2) { 2 }
      let(:fret_number_1) { 0 }
      let(:fret_number_2) { 0 }
      it { expect(fret_1 == fret_2).to be false }
    end
    context "異なるフレット番号の場合" do
      let(:note_1) { Tetsujin::Theory::Note.new(pitch_class: 0, octave: 4) }
      let(:note_2) { Tetsujin::Theory::Note.new(pitch_class: 0, octave: 4) }
      let(:string_number_1) { 1 }
      let(:string_number_2) { 1 }
      let(:fret_number_1) { 0 }
      let(:fret_number_2) { 1 }
      it { expect(fret_1 == fret_2).to be false }
    end
  end

  describe "#pressed?" do
    let(:note) { Tetsujin::Theory::Note.new(pitch_class: 0, octave: 4) }
    let(:string_number) { 1 }
    let(:fret_number) { 0 }
    let(:fret) { described_class.new(note: note, string_number: string_number, fret_number: fret_number) }
    context "押されていない場合" do
      it { expect(fret.pressed?).to be false }
    end
    context "押されている場合" do
      before { fret.press! }
      it { expect(fret.pressed?).to be true }
    end
  end

  describe "#press!" do
    let(:note) { Tetsujin::Theory::Note.new(pitch_class: 0, octave: 4) }
    let(:string_number) { 1 }
    let(:fret_number) { 0 }
    let(:fret) { described_class.new(note: note, string_number: string_number, fret_number: fret_number) }
    context "押されていない場合" do
      it { expect(fret.pressed?).to be false }
    end
    context "押されている場合" do
      before { fret.press! }
      it { expect(fret.pressed?).to be true }
    end
  end

  describe "#release!" do
    let(:note) { Tetsujin::Theory::Note.new(pitch_class: 0, octave: 4) }
    let(:string_number) { 1 }
    let(:fret_number) { 0 }
    let(:fret) { described_class.new(note: note, string_number: string_number, fret_number: fret_number) }
    context "元々押されていない場合" do
      it do
        fret.release!
        expect(fret.pressed?).to be false
      end
    end
    context "元々押されていた場合" do
      before { fret.press! }
      it do
        fret.release!
        expect(fret.pressed?).to be false
      end
    end
  end
end
