# == Schema Information
#
# Table name: entries
#
#  id               :integer          not null, primary key
#  summary          :string(255)
#  notes            :text
#  day              :integer
#  week             :integer
#  created_at       :datetime
#  updated_at       :datetime
#  distance         :string           default("0 m")
#  duration         :string           default("0 s")
#  occurs_on        :date
#  schedulable_id   :integer
#  schedulable_type :string
#

require 'rails_helper'

RSpec.describe Entry, :type => :model do

  describe "#distance" do
    it "updates distance unit (meters)" do
      subject.distance = '400 cm'

      expect(subject.distance_in('m')).to eq('4 m')
    end

    it "converts given distance unit object string to meters" do
      subject.distance = '3 mi'

      expect(subject.distance_for_unit('mi').round).to eq(Unit('3 mi'))
      expect(subject.distance_in('m').round).to eq(Unit('4828 m'))
    end

    it "infers distance unit from distance" do
      expect(subject.distance_for_unit('mi')).to eq(Unit('0 mi'))

      subject.distance = '4828 m' # meters

      expect(subject.distance_for_unit('mi').round).to eq(Unit('3 mi'))
    end

    it "handles range of distances" do
      subject.distance = '2 - 3 mi'

      expect(subject.distance_for_unit('mi').round).to eq(Unit('3 mi'))
      expect(subject.distance_in('m').round).to eq(Unit('4828 m'))
    end
  end

  describe "#duration" do
    it "updates duration unit (s)" do
      subject.duration = '1 hr'

      expect(subject.duration_in('s')).to eq('3600 s')
    end

    it "converts given duration unit string to minutes" do
      subject.duration = '48 min' # 4828.03 meters

      expect(subject.duration_for_unit('min').round).to eq(Unit('48 min'))
      expect(subject.duration_in('s').round).to eq(Unit('48 min').convert_to('seconds'))
    end

    it "infers duration unit from duration" do
      expect(subject.duration_for_unit('min')).to eq(Unit('0 min'))

      subject.duration = '3600 s'

      expect(subject.duration_for_unit('min').round).to eq(Unit('60 min'))
    end

    it "handles range of durations" do
      subject.duration = '36 - 48 min'

      expect(subject.duration_for_unit('min').round).to eq(Unit('48 min'))
      expect(subject.duration_in('s').round).to eq(Unit('48 min').convert_to('seconds'))
    end

    it "handles hour notation" do
      subject.duration = '1:00'

      expect(subject.duration_for_unit('min').round).to eq(Unit('60 min'))
      expect(subject.duration_in('s').round).to eq(Unit('60 min').convert_to('seconds'))
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
