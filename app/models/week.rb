require 'virtus'

class Week
  include Virtus.model

  attribute :number, Integer
  attribute :ends_on, Date
  attribute :starts_on, Date
  attribute :title, String, default: :default_title

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

  def starts_on
    ensure_date { @starts_on || ends_on - 6.days }
  end

  def ends_on
    ensure_date { @ends_on   || starts_on + 6.days }
  end

  def days
    (starts_on..ends_on)
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
