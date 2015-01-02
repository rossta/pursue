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
#  distance         :string           default("0 m")
#  duration         :string           default("0 s")
#

class Entry < ActiveRecord::Base
  include Concerns::Categorizable

  belongs_to :training_plan

  has_many :schedule_entries

  enum day: %w[ Monday Tuesday Wednesday Thursday Friday Saturday Sunday ]

  validates :week, numericality: { greater_than: 0, less_than_or_equal_to: :total_weeks }

  # validates :duration, duration_unit: true
  # validates :distance, distance_unit: true

  has_one_category :period
  has_one_category :discipline
  has_one_category :zone
  has_one_category :mode
  has_many_categories :abilities
  has_many_categories :strength_abilities

  def combined_ability_names
    ability_names + strength_ability_names
  end

  def training_week
    @training_week ||= TrainingWeek.new(number: week)
  end

  def self.day_names
    days.keys
  end

  def total_weeks
    training_plan.total_weeks
  end

  def title
    [display_week, display_day].reject(&:blank?).join(' ')
  end

  def display_day
    day
  end

  def display_week
    training_week.title
  end

  def distance=(given_distance)
    self.distance_unit = given_distance
    super
  end

  def distance_unit=(given_distance)
    @distance_unit = to_unit(given_distance)
  end

  def distance_unit
    @distance_unit || to_unit(self.distance)
  end

  def distance_for_unit(unit_name = 'm')
    distance_unit.convert_to(unit_name)
  end
  alias :distance_in :distance_for_unit

  def duration=(given_duration)
    self.duration_unit = given_duration
    super
  end

  def duration_unit=(given_duration)
    @duration_unit = to_unit(given_duration)
  end

  def duration_unit
    to_unit(self.duration)
  end

  def duration_for_unit(unit_name = 's')
    duration_unit.convert_to(unit_name)
  end
  alias :duration_in :duration_for_unit

  def date_relative_to(date)
    return NullDate.new unless week.present? && day.present?
    date.to_date + week_index.weeks + day_index.days
  end

  def week_index
    week.presence && (week - 1)
  end

  def day_index
    day.presence && Entry.days[day]
  end

  def to_unit(value)
    return nil if value.blank?

    Unit(extract_last_unit_value(value))
  end

  def extract_last_unit_value(value)
    value.split(%r{\s?-\s?}).last.strip
  end
end
