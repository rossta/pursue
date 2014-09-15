require 'virtus'

class Week
  include Virtus.model

  attribute :ends_on, Date
  attribute :starts_on, Date

  attribute :number, Integer
  attribute :title, String, default: :default_title

  def self.of_date(date)
    Week.new(starts_on: date.beginning_of_week)
  end

  def self.upto(ends_on, num)
    ends_on ||= NullDate.new("TBD")
    [].tap do |weeks|
      date = ends_on - (num - 1).weeks
      num.times do |i|
        week = new(number: i+1, ends_on: date + i.weeks)
        yield week if block_given?
        weeks << week
      end
    end
  end

  def self.following(starts_on, num)
    starts_on ||= NullDate.new("TBD")
    [].tap do |weeks|
      num.times do |i|
        week = new(number: i+1, starts_on: starts_on + i.weeks)
        yield week if block_given?
        weeks << week
      end
    end
  end

  def ==(week)
    week.kind_of?(Week) && starts_on == week.starts_on
  end

  def to_s
    "<Week starts_on: #{I18n.l(starts_on, format: :short)}>"
  end
  alias_method :inspect, :to_s

  def starts_on
    ensure_date { @starts_on || ends_on - 6.days }.to_date
  end

  def ends_on
    ensure_date { @ends_on   || starts_on + 6.days }.to_date
  end

  def days
    (starts_on..ends_on)
  end

  def has_dates?
    starts_on.present? && !starts_on.is_a?(NullDate)
  end

  def day_date(day)
    # Day(day)
    enums = %w[ Monday Tuesday Wednesday Thursday Friday Saturday Sunday ]
    days.to_a[enums.index(day)]
  end

  def default_title
    "Week #{number}"
  end

  private

  def ensure_date(&block)
    if @starts_on.nil? && @ends_on.nil?
      @starts_on = NullDate.new("Unknown start date")
      @ends_on = NullDate.new("Unknown end date")
    else
      block.call
    end
  end

end
