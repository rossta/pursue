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

class TrainingPlan < ActiveRecord::Base
  include Concerns::Categorizable

  has_one_category :discipline

  belongs_to :creator, class_name: 'User'

  has_many :entries

  def total_weeks
    read_attribute(:total_weeks) || 27
  end

  def peak_week
    read_attribute(:peak_week) || total_weeks
  end

  def duration
    1..total_weeks
  end

  def weeks
    weeks_following(nil)
  end

  def weeks_following(start_date)
    TrainingWeek.following(start_date, total_weeks) do |w, i|
      number = i + 1
      w.number = number
      w.period = periodization.period(number)
    end
  end

  def week_number(number)
    weeks[number.to_i-1]
  end

  def period(week_number)
    periodization.period(week_number)
  end

  def starts_on(peaks_on)
    peaks_on + 1.day - peak_week.weeks
  end

  def ends_on(peaks_on)
    peaks_on + (total_weeks - peak_week).weeks
  end

  def exists?
    persisted?
  end

  def periodization
    @periodization ||= Friel.new(peak_week)
  end

  class Friel
    include Enumerable

    DEFAULT_PEAK_WEEK = 27

    PERIODS = [
      Period.new("Prep" ,      1..4,    cover: -> (i) { i <= range.last } ),
      Period.new("Base" ,      5..16,   chunks: 3                         ),
      Period.new("Build",      17..24,  chunks: 2                         ),
      Period.new("Peak",       25..26,  chunks: 2                         ),
      Period.new("Race",       27..27                                     ),
      Period.new("Transition", 28...30, cover: ->(i) { i >= range.first } )
    ]

    attr_reader :peak_week

    def initialize(peak_week = DEFAULT_PEAK_WEEK)
      @peak_week = peak_week
    end

    def each(&block)
      weeks.each(&block)
    end

    def weeks
      @weeks ||= 1.upto(peak_week).map do |number|
        TrainingWeek.new(number: number, period: period(number))
      end
    end

    def period(week_number)
      PERIODS.find { |period| period.cover?(week_number) }
    end

    def period_name(week_number)
      period(week_number).name
    end

  end
end
