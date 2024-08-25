# frozen_string_literal: true

RSpec.describe Tetsujin::Theory::Note do
  describe "#initialize" do
    context "正しいピッチクラスとオクターブの場合" do
      let(:pitch_class) { 0 }
      let(:octave) { 4 }
      it { expect { described_class.new(pitch_class: pitch_class, octave: octave) }.not_to raise_error }
    end
    context "不正なピッチクラスの場合" do
      let(:pitch_class) { 13 }
      let(:octave) { 4 }
      it { expect { described_class.new(pitch_class: pitch_class, octave: octave) }.to raise_error ArgumentError }
    end
    context "不正なオクターブの場合" do
      let(:pitch_class) { 0 }
      let(:octave) { "hoge" }
      it { expect { described_class.new(pitch_class: pitch_class, octave: octave) }.to raise_error TypeError }
    end
  end

  describe "#to_s" do
    let(:note) { described_class.new(pitch_class: 0, octave: 4) }
    it { expect(note.to_s).to eq "C4" }
  end

  describe "#==" do
    context "同じ音の場合" do
      let(:note1) { described_class.new(pitch_class: 0, octave: 4) }
      let(:note2) { described_class.new(pitch_class: 0, octave: 4) }
      it { expect(note1 == note2).to eq true }
    end
    context "違う音の場合" do
      let(:note1) { described_class.new(pitch_class: 0, octave: 4) }
      let(:note2) { described_class.new(pitch_class: 2, octave: 4) }
      it { expect(note1 == note2).to eq false }
    end
  end

  describe "#add" do
    context "interval が正の値の場合" do
      context "オクターブをまたがない場合" do
        let(:c_note) { described_class.new(pitch_class: 0, octave: 4) }
        let(:d_note) { described_class.new(pitch_class: 2, octave: 4) }
        let(:interval) { Tetsujin::Theory::Interval.new(value: 2) }
        it { expect(c_note.add(interval)).to eq d_note }
      end
      context "オクターブをまたぐ場合" do
        let(:c_note) { described_class.new(pitch_class: 0, octave: 4) }
        let(:d_note) { described_class.new(pitch_class: 2, octave: 5) }
        let(:interval) { Tetsujin::Theory::Interval.new(value: 14) }
        it { expect(c_note.add(interval)).to eq d_note }
      end
    end
    context "interval が負の値の場合" do
      context "オクターブをまたがない場合" do
        let(:d_note) { described_class.new(pitch_class: 2, octave: 4) }
        let(:c_note) { described_class.new(pitch_class: 0, octave: 4) }
        let(:interval) { Tetsujin::Theory::Interval.new(value: -2) }
        it { expect(d_note.add(interval)).to eq c_note }
      end
      context "オクターブをまたぐ場合" do
        let(:d_note) { described_class.new(pitch_class: 2, octave: 4) }
        let(:c_note) { described_class.new(pitch_class: 0, octave: 3) }
        let(:interval) { Tetsujin::Theory::Interval.new(value: -14) }
        it { expect(d_note.add(interval)).to eq c_note }
      end
    end
  end

  describe "#subtract" do
    context "interval が正の値の場合" do
      context "オクターブをまたがない場合" do
        let(:c_note) { described_class.new(pitch_class: 0, octave: 4) }
        let(:d_note) { described_class.new(pitch_class: 2, octave: 4) }
        let(:interval) { Tetsujin::Theory::Interval.new(value: 2) }
        it { expect(d_note.subtract(interval)).to eq c_note }
      end
      context "オクターブをまたぐ場合" do
        let(:c_note) { described_class.new(pitch_class: 0, octave: 4) }
        let(:d_note) { described_class.new(pitch_class: 2, octave: 5) }
        let(:interval) { Tetsujin::Theory::Interval.new(value: 14) }
        it { expect(d_note.subtract(interval)).to eq c_note }
      end
    end
    context "interval が負の値の場合" do
      context "オクターブをまたがない場合" do
        let(:d_note) { described_class.new(pitch_class: 2, octave: 4) }
        let(:c_note) { described_class.new(pitch_class: 0, octave: 4) }
        let(:interval) { Tetsujin::Theory::Interval.new(value: -2) }
        it { expect(c_note.subtract(interval)).to eq d_note }
      end
      context "オクターブをまたぐ場合" do
        let(:d_note) { described_class.new(pitch_class: 2, octave: 4) }
        let(:c_note) { described_class.new(pitch_class: 0, octave: 3) }
        let(:interval) { Tetsujin::Theory::Interval.new(value: -14) }
        it { expect(c_note.subtract(interval)).to eq d_note }
      end
    end
  end

  describe "#diff" do
    let(:c_note) { described_class.new(pitch_class: 0, octave: 4) }
    let(:d_note) { described_class.new(pitch_class: 2, octave: 4) }
    it { expect(c_note.diff(d_note)).to eq Tetsujin::Theory::Interval.new(value: 2) }
  end

  describe "#<=>" do
    context "ある note A と note B が同じオクターブの場合" do
      context "note A が note B よりも高い場合" do
        let(:c_note) { described_class.new(pitch_class: 0, octave: 4) }
        let(:d_note) { described_class.new(pitch_class: 2, octave: 4) }
        it { expect(c_note <=> d_note).to eq -1 }
      end
      context "note A が note B よりも低い場合" do
        let(:d_note) { described_class.new(pitch_class: 2, octave: 4) }
        let(:c_note) { described_class.new(pitch_class: 0, octave: 4) }
        it { expect(d_note <=> c_note).to eq 1 }
      end
      context "note A と note B が同じ音の場合" do
        let(:c_note) { described_class.new(pitch_class: 0, octave: 4) }
        let(:c_note2) { described_class.new(pitch_class: 0, octave: 4) }
        it { expect(c_note <=> c_note2).to eq 0 }
      end
    end
    context "ある note A が note B よりも低いオクターブの場合" do
      context "note A が note B よりも高い場合" do
        let(:c_note) { described_class.new(pitch_class: 0, octave: 3) }
        let(:d_note) { described_class.new(pitch_class: 2, octave: 4) }
        it { expect(c_note <=> d_note).to eq -1 }
      end
      context "note A が note B よりも低い場合" do
        let(:d_note) { described_class.new(pitch_class: 2, octave: 3) }
        let(:c_note) { described_class.new(pitch_class: 0, octave: 4) }
        it { expect(d_note <=> c_note).to eq -1 }
      end
      context "note A と note B が同じ音の場合" do
        let(:c_note) { described_class.new(pitch_class: 0, octave: 3) }
        let(:c_note2) { described_class.new(pitch_class: 0, octave: 4) }
        it { expect(c_note <=> c_note2).to eq -1 }
      end
    end
  end
end
