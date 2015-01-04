require 'rails_helper'

RSpec.describe TrainingWeek do
  subject(:period) { double(name: "Build", mode: "Train", chunk: nil) }
  subject(:week) { TrainingWeek.new(number: 1, period: period) }

  it { expect(week.number).to eq 1 }
  it { expect(week.title).to eq 'Week 1 Build Train' }

  it "accepts given title" do
    week.title = 'Build Week'
    expect(week.title).to eq 'Build Week'
  end
end
