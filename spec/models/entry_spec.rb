# == Schema Information
#
# Table name: entries
#
#  id               :integer          not null, primary key
#  summary          :string(255)
#  notes            :text
#  day              :integer
#  week             :integer
#  training_plan_id :integer          not null
#  created_at       :datetime
#  updated_at       :datetime
#  distance         :decimal(, )      default(0.0)
#  duration         :integer          default(0)
#

require 'rails_helper'

RSpec.describe Entry, :type => :model do

  describe "#distance" do
    it "enforces to decimal scale (cm) on meters" do
      subject.distance = 4.345
      expect(subject.distance).to eq(4.35)
    end
  end

  describe "#distance_unit" do
    it "converts given distance unit string to meters" do
      subject.distance_unit = '3 mi' # 4828.03 meters
      expect(subject.distance_for_unit('mi').round).to eq(Unit('3 mi'))
      expect(subject.distance).to eq(Unit('3 mi').convert_to('meters').scalar.to_f.round(2))
    end

    it "converts given distance unit object string to meters" do
      subject.distance_unit = Unit('3 mi')
      expect(subject.distance_for_unit('mi').round).to eq(Unit('3 mi'))
      expect(subject.distance).to eq(Unit('3 mi').convert_to('meters').scalar.to_f.round(2))
    end

    it "infers distance unit from distance" do
      expect(subject.distance_for_unit('mi')).to eq(Unit('0 mi'))

      subject.distance = 4828.03 # meters
      expect(subject.distance_for_unit('mi').round).to eq(Unit('3 mi'))
    end
  end

  describe "#duration_unit" do
    it "converts given duration unit string to minutes" do
      subject.duration_unit = '48 min' # 4828.03 meters
      expect(subject.duration_for_unit('min').round).to eq(Unit('48 min'))
      expect(subject.duration).to eq(Unit('48 min').convert_to('seconds').scalar.to_i)
    end

    it "converts given duration unit object string to meters" do
      subject.duration_unit = Unit('48 min')
      expect(subject.duration_for_unit('min').round).to eq(Unit('48 min'))
      expect(subject.duration).to eq(Unit('48 min').convert_to('seconds').scalar.to_i)
    end

    it "infers duration unit from duration" do
      expect(subject.duration_for_unit('min')).to eq(Unit('0 min'))

      subject.duration = 3600 # meters
      expect(subject.duration_for_unit('min').round).to eq(Unit('60 min'))
    end
  end

  describe "#date_relative_to" do
    it "returns null date" do
      subject.day = nil
      subject.week = nil
      expect(subject.date_relative_to(Date.today)).to eq NullDate.new

      subject.day = 2
      expect(subject.date_relative_to(Date.today)).to eq NullDate.new

      subject.week = 3
      subject.day = nil
      expect(subject.date_relative_to(Date.today)).to eq NullDate.new
    end

    it "returns relative date to week and day" do
      subject.day = 2
      subject.week = 3
      given_date = Date.today
      expected_date = given_date + 2.weeks + 2.days
      expect(subject.date_relative_to(given_date)).to eq expected_date
    end
  end
end
