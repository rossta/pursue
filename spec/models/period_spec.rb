require 'rails_helper'

RSpec.describe Period do
  subject(:period) { Period.new("Build", 1..12) }

  it { expect(period.name).to eq "Build" }
  it { expect(period.range).to eq (1..12) }

  describe "#cover?" do
    it { expect(period.cover?(1)).to be_truthy }
    it { expect(period.cover?(12)).to be_truthy }
    it { expect(period.cover?(-1)).to be_falsey }
    it { expect(period.cover?(13)).to be_falsey }

    it "can be modified through options" do
      period = Period.new("Build", 1..12, cover: -> (num) { num < range.last })
      expect(period.cover?(1)).to be_truthy
      expect(period.cover?(12)).to be_falsey
      expect(period.cover?(-1)).to be_truthy
      expect(period.cover?(13)).to be_falsey
    end
  end

  describe "#mode" do
    it { expect(period.mode(0)).to be_nil }
    it { expect(period.mode(1)).to eq "Train" }
    it { expect(period.mode(4)).to eq "Rest" }
    it { expect(period.mode(7)).to eq "Train" }
    it { expect(period.mode(8)).to eq "Rest" }
    it { expect(period.mode(11)).to eq "Train" }
    it { expect(period.mode(12)).to eq "Rest" }
    it { expect(period.mode(13)).to be_nil }
  end

  describe "#chunk" do
    it { expect(period.chunk(1)).to be_nil }
    it { expect(period.chunk(12)).to be_nil }

    it "chunks less than range size" do
      period = Period.new("Build", 1..12, chunks: 3)
      expect(period.chunk(0)).to be_nil
      expect(period.chunk(1)).to eq 1
      expect(period.chunk(7)).to eq 2
      expect(period.chunk(12)).to eq 3
      expect(period.chunk(13)).to be_nil
    end

    it "chunk equal to range" do
      period = Period.new("Peak", 1..2, chunks: 2)
      expect(period.chunk(0)).to be_nil
      expect(period.chunk(1)).to eq 1
      expect(period.chunk(2)).to eq 2
      expect(period.chunk(3)).to be_nil
    end

    it "chunk greater than range" do
      period = Period.new("Nonsense", 1..2, chunks: 4)
      expect(period.chunk(0)).to be_nil
      expect(period.chunk(1)).to be_nil
      expect(period.chunk(2)).to be_nil
      expect(period.chunk(3)).to be_nil
    end
  end
end
