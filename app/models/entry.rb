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

class Entry < ActiveRecord::Base
  include Concerns::Categorizable

  belongs_to :training_plan

  has_many :schedule_entries

  enum day: %w[ Monday Tuesday Wednesday Thursday Friday Saturday Sunday ]

  validates :week, numericality: { greater_than: 0, less_than_or_equal_to: :total_weeks }

  has_one_category :period
  has_one_category :discipline
  has_one_category :zone
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
    @distance_unit = nil
    super(sprintf("%0.02f", given_distance.round(2)))
  end

  def distance_unit=(given_distance_unit)
    Unit(given_distance_unit).tap do |unit|
      self.distance = unit.convert_to('meters').scalar.to_f
    end
  end

  def distance_unit
    Unit.new(self.distance, 'meters')
  end

  def distance_for_unit(unit_name)
    distance_unit.convert_to(unit_name)
  end

  def duration_unit=(given_duration_unit)
    Unit(given_duration_unit).tap do |unit|
      self.duration = unit.convert_to('seconds').scalar.to_i
    end
  end

  def duration_unit
    Unit.new(self.duration, 'seconds')
  end

  def duration_for_unit(unit_name)
    duration_unit.convert_to(unit_name)
  end

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
end
