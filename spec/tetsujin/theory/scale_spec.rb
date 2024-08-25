# frozen_string_literal: true

RSpec.describe Tetsujin::Theory::Scale do
  describe "#initialize" do
    context "正しいルート音と構成パターンの場合" do
      let(:root) { Tetsujin::Theory::Note.new(pitch_class: 0, octave: 4) }
      let(:pattern) { :major }
      it { expect { described_class.new(root: root, pattern: pattern) }.not_to raise_error }
    end
    context "不正なルート音の場合" do
      let(:root) { 0 }
      let(:pattern) { :major }
      it { expect { described_class.new(root: root, pattern: pattern) }.to raise_error TypeError }
    end
    context "不正な構成パターンの場合" do
      context "構成パターンがシンボルではない場合" do
        let(:root) { Tetsujin::Theory::Note.new(pitch_class: 0, octave: 4) }
        let(:pattern) { "major" }
        it { expect { described_class.new(root: root, pattern: pattern) }.to raise_error TypeError }
      end
      context "存在しない構成パターンの場合" do
        let(:root) { Tetsujin::Theory::Note.new(pitch_class: 0, octave: 4) }
        let(:pattern) { :hoge }
        it { expect { described_class.new(root: root, pattern: pattern) }.to raise_error ArgumentError }
      end
    end
  end

  describe "#notes" do
    let(:root) {   Tetsujin::Theory::Note.new(pitch_class: 0, octave: 4) }
    let(:d_note) { Tetsujin::Theory::Note.new(pitch_class: 2, octave: 4) }
    let(:e_note) { Tetsujin::Theory::Note.new(pitch_class: 4, octave: 4) }
    let(:f_note) { Tetsujin::Theory::Note.new(pitch_class: 5, octave: 4) }
    let(:g_note) { Tetsujin::Theory::Note.new(pitch_class: 7, octave: 4) }
    let(:a_note) { Tetsujin::Theory::Note.new(pitch_class: 9, octave: 4) }
    let(:b_note) { Tetsujin::Theory::Note.new(pitch_class: 11, octave: 4) }
    let(:c_note) { Tetsujin::Theory::Note.new(pitch_class: 0, octave: 5) }
    let(:pattern) { :major }
    let(:scale) { described_class.new(root: root, pattern: pattern) }
    it { expect(scale.notes).to eq [root, d_note, e_note, f_note, g_note, a_note, b_note, c_note] }
  end

  describe "#==" do
    let(:root) { Tetsujin::Theory::Note.new(pitch_class: 0, octave: 4) }
    let(:pattern) { :major }
    let(:scale1) { described_class.new(root: root, pattern: pattern) }
    let(:scale2) { described_class.new(root: root, pattern: pattern) }
    it { expect(scale1 == scale2).to be true }
  end
end
