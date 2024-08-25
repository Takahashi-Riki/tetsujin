# frozen_string_literal: true

RSpec.describe Tetsujin::Theory::Interval do
  describe "#initialize" do
    context "正しい値の場合" do
      let(:value) { 1 }
      it { expect { described_class.new(value: value) }.not_to raise_error }
    end
    context "不正な値の場合" do
      let(:value) { "hoge" }
      it { expect { described_class.new(value: value) }.to raise_error TypeError }
    end
  end

  describe "#==" do
    context "同じ値の場合" do
      let(:interval1) { described_class.new(value: 1) }
      let(:interval2) { described_class.new(value: 1) }
      it { expect(interval1 == interval2).to eq true }
    end
    context "違う値の場合" do
      let(:interval1) { described_class.new(value: 1) }
      let(:interval2) { described_class.new(value: 2) }
      it { expect(interval1 == interval2).to eq false }
    end
  end
end
