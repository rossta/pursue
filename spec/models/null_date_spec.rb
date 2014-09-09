require 'spec_helper'

RSpec.describe NullDate do
  let(:date) { NullDate.new("TBD") }

  it { expect(date).to eq NullDate.new }
  it { expect(date + 1.day).to eq(date) }
  it { expect(date - 2.hours).to eq(date) }
  it { expect((date..NullDate.new).to_a).to eq [NullDate.new] }
  it { expect((date...NullDate.new).to_a).to eq [] }
  it { expect(date << 123).to eq NullDate.new }
  it { expect(date >> 123).to eq NullDate.new }
  it { expect(date.to_s).to eq("TBD") }
  it { expect(date.to_s(:long)).to eq("TBD") }
  it { expect(date.strftime).to eq("TBD") }
  it { expect(date.strftime("%Y")).to eq("TBD") }
end
