# A Period represents a block of training with a specific purpose
# A TrainingWeek is associated with training Period.
#
# name
# def mode(week_number)
# def version(week_number)

class Period
  attr_reader :name, :range, :cover

  def initialize(name, range, options = {})
    @name, @range = name, range
    @cover  = options[:cover]
    @chunks = options[:chunks]
  end

  def to_s
    "<#{self.class} name=#{name}>"
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
    return nil unless range.cover?(week)
    return "Train" unless range.size >= 4

    week % 4 == 0 ? "Rest" : "Train"
  end

  def chunk(week)
    return nil unless !!@chunks
    return nil unless range.cover?(week)

    div = range.size / @chunks.to_i
    return nil unless div >= 1

    diff = week - range.first
    ((diff / div)+1).to_i
  end
end

