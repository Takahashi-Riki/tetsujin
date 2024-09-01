# frozen_string_literal: true

RSpec.describe Tetsujin::DSL::Theory do
  describe "#create_note" do
    let(:name) { "C" }
    let(:octave) { 4 }
    let(:pitch_class) { 0 }
    let(:note) { Tetsujin::Theory::Note.new(pitch_class: pitch_class, octave: octave) }
    let(:dummy_class) { Class.new { include Tetsujin::DSL::Theory } }
    it { expect(dummy_class.new.create_note(name, octave)).to eq note }
  end

  describe "#create_scale" do
    let(:root) { Tetsujin::Theory::Note.new(pitch_class: 0, octave: 4) }
    let(:pattern) { :major }
    let(:scale) { Tetsujin::Theory::Scale.new(root: root, pattern: pattern) }
    let(:dummy_class) { Class.new { include Tetsujin::DSL::Theory } }
    it { expect(dummy_class.new.create_scale(root, pattern)).to eq scale }
  end
end
