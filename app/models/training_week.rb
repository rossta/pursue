class TrainingWeek < Week
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attribute :number, Integer
  attribute :title, String
  attribute :period, Period

  def self.model_name
    ActiveModel::Name.new(Week)
  end

  def id
    number
  end

  def persisted?
    false
  end

  def to_param
    number.to_s
  end

  def title
    @title || "Week #{to_a.join(' ')}"
  end

  def to_a
    [number, period_name, chunk, mode].map(&:to_s).reject(&:blank?)
  end

  def to_s
    "<#{self.class}:#{to_a.inspect} period=#{period} number=#{number}>"
  end

  def period_name
    period.name
  end

  def mode
    period.mode(number)
  end

  def chunk
    period.chunk(number)
  end
end
