require 'rails_helper'

RSpec.describe Periodization::Friel do
  subject(:periodization) { described_class.new }

  it { expect(periodization.peak_week).to eq 27 }

  it { expect(periodization.weeks.size).to eq 27 }

  describe "#period_name" do
    it { expect(periodization.period_name(0)).to eq "Prep" }
    it { expect(periodization.period_name(1)).to eq "Prep" }
    it { expect(periodization.period_name(4)).to eq "Prep" }

    it { expect(periodization.period_name(5)).to eq "Base" }
    it { expect(periodization.period_name(16)).to eq "Base" }

    it { expect(periodization.period_name(17)).to eq "Build" }
    it { expect(periodization.period_name(24)).to eq "Build" }

    it { expect(periodization.period_name(25)).to eq "Peak" }
    it { expect(periodization.period_name(26)).to eq "Peak" }

    it { expect(periodization.period_name(27)).to eq "Race" }

    it { expect(periodization.period_name(28)).to eq "Transition" }
    it { expect(periodization.period_name(32)).to eq "Transition" }
  end
end
