require 'rails_helper'

RSpec.describe Week do

  describe "#ends_on" do
    let(:date) { 1.week.from_now.end_of_week }
    let(:week) { Week.new(number: 1, ends_on: date) }

    it { expect(week.ends_on).to eq(date) }
    it { expect(week.starts_on).to eq(date - 6.days) }
  end

  describe "#starts_on" do
    let(:date) { 1.week.from_now.beginning_of_week }
    let(:week) { Week.new(number: 1, starts_on: date) }

    it { expect(week.starts_on).to eq(date) }
    it { expect(week.ends_on).to eq(date + 6.days) }
  end

  describe "no dates" do
    let(:week) { Week.new }

    it { expect(week.starts_on).to be_a(NullDate) }
    it { expect(week.ends_on).to be_a(NullDate) }
  end

  describe "self.upto" do
    let(:date) { 10.weeks.from_now.end_of_week.to_date }

    it "returns array of weeks up to date" do
      weeks = Week.upto(date, 5)

      expect(weeks.length).to eq 5
      expect(weeks.first.ends_on).to eq 6.weeks.from_now.end_of_week.to_date
      expect(weeks.last.ends_on).to eq 10.weeks.from_now.end_of_week.to_date
    end

    it "yields each week if block given" do
      weeks = Week.upto(date, 2) do |w|
        w.title = "foobar"
      end
      expect(weeks.map(&:title)).to eq(%w[foobar foobar])
    end
  end

  describe "self.following" do
    let(:date) { 5.weeks.from_now.beginning_of_week.to_date }

    it "returns array of weeks up to date" do
      weeks = Week.following(date, 5)

      expect(weeks.length).to eq 5
      expect(weeks.first.starts_on).to eq 5.weeks.from_now.beginning_of_week.to_date
      expect(weeks.last.starts_on).to eq 9.weeks.from_now.beginning_of_week.to_date
    end

    it "yields each week if block given" do
      weeks = Week.following(date, 2) do |w|
        w.title = "foobar"
      end
      expect(weeks.map(&:title)).to eq(%w[foobar foobar])
    end
  end

end
