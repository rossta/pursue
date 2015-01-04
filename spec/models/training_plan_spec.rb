# == Schema Information
#
# Table name: training_plans
#
#  id          :integer          not null, primary key
#  title       :string(255)      not null
#  summary     :string(255)
#  creator_id  :integer          not null
#  created_at  :datetime
#  updated_at  :datetime
#  total_weeks :integer
#  peak_week   :integer
#

require 'rails_helper'

RSpec.describe TrainingPlan, :type => :model do
end

RSpec.describe TrainingPlan::Friel do
  subject(:periodization) { TrainingPlan::Friel.new }

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

RSpec.describe TrainingPlan::Friel::Period do
  subject(:period) { described_class.new("Prep", (1..4)) }

  it { expect(period.name).to eq "Prep" }
  it { expect(period.range).to eq (1..4) }
  it { expect(period.cover?(1)).to be true }
  it { expect(period.cover?(4)).to be true }
  it { expect(period.cover?(5)).to be false }
  it { expect(period.mode(3)).to eq "Train" }
  it { expect(period.mode(4)).to eq "Rest" }
  it { expect(period.version(3)).to be_nil }
  it { expect(described_class.new("Prep", (5..16)).version(11)).to eq 2 }
end
