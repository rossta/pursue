class Periodization
  class Friel < Periodization
    DEFAULT_PEAK_WEEK = 27

    attribute :peak_week, Integer, default: DEFAULT_PEAK_WEEK

    PERIODS = [
      Period.new("Prep" ,      1..4,    cover: -> (i) { i <= range.last } ),
      Period.new("Base" ,      5..16,   chunks: 3                         ),
      Period.new("Build",      17..24,  chunks: 2                         ),
      Period.new("Peak",       25..26,  chunks: 2                         ),
      Period.new("Race",       27..27                                     ),
      Period.new("Transition", 28...30, cover: ->(i) { i >= range.first } )
    ]

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
