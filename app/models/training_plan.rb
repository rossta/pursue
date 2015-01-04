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
    read_attribute(:total_weeks) || 36
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
      w.number = i + 1
      w.title = periodized_week_title(w)
    end
  end

  def week_number(number)
    weeks[number.to_i-1]
  end

  def periodized_week_title(week)
    period = periodization.period_name(week.number) || "Prep"
    "#{period}: #{week.title}"
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

    class Period
      attr_reader :name, :range, :cover

      def initialize(name, range, cover = nil)
        @name, @range, @cover = name, range, cover
      end

      def to_s
        "<#{self.class} \nname=#{name}>"
      end
      alias inspect to_s

      def cover?(remaining_weeks)
        if @cover
          instance_exec remaining_weeks, &cover
        else
          @range.cover?(remaining_weeks)
        end
      end

      def mode(week)
        return "Train" unless range.size >= 4
        week % 4 == 0 ? "Rest" : "Train"
      end

      def version(week)
        return nil unless range.size > 4
        return nil unless range.cover?(week)
        diff = week - range.first
        ((diff / 4)+1).to_i
      end
    end

    PERIODS = [
      Period.new("Transition", (28...30), ->(i) { i >= range.first }),
      Period.new("Race",       (27..27)),
      Period.new("Peak",       (25..26)),
      Period.new("Build",      (17..24)),
      Period.new("Base" ,      (5..16)),
      Period.new("Prep" ,      (1..4), -> (i) { i <= range.last })
    ]

    PeriodWeek = Struct.new(:number, :period) do
      def to_a
        [number, name, version, mode].map(&:to_s).reject(&:blank?)
      end

      def to_s
        "<#{self.class}:#{to_a.inspect} \nperiod=#{period}\nnumber=#{number}>"
      end

      def name
        period.name
      end

      def mode
        period.mode(number)
      end

      def version
        period.version(number)
      end
    end

    attr_reader :peak_week

    def initialize(peak_week = DEFAULT_PEAK_WEEK)
      @peak_week = peak_week
    end

    def each(&block)
      weeks.each(&block)
    end

    def weeks
      @weeks ||= 1.upto(peak_week).map { |i| PeriodWeek.new(i, period(i)) }
    end

    def period(week_number)
      PERIODS.find { |period| period.cover?(week_number) }
    end

    def period_name(week_number)
      period(week_number).name
    end

  end
end
