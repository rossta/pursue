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

class Entry < ActiveRecord::Base
  include Concerns::Categorizable

  belongs_to :schedulable, polymorphic: true, inverse_of: :entries

  belongs_to :schedule, -> { joins(:entries).merge(Entry.for_schedules) }, foreign_key: :schedulable_id
  belongs_to :training_plan, -> { joins(:entries).merge(Entry.for_training_plans) }, foreign_key: :schedulable_id

  scope :today, -> { where(occurs_on: Time.zone.today.to_date ) }
  scope :tomorrow, -> { where(occurs_on: Time.zone.tomorrow.to_date ) }
  scope :for_schedules, -> { where(schedulable_type: 'Schedule') }
  scope :for_training_plans, -> { where(schedulable_type: 'TrainingPlan') }

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

  def secondary_category_names
    combined_ability_names + [zone_name, mode_name].reject(&:blank?)
  end

  def training_week
    @training_week ||= TrainingWeek.new(number: week, period: schedulable.period(week))
  end

  def self.day_names
    days.keys
  end

  def total_weeks
    schedulable.total_weeks
  end

  def title
    [display_week, summary, display_day].reject(&:blank?).join(' ')
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

  def distance_for_discipline
    distance_for_unit discipline_distance_unit
  end

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

  def copyable_attributes
    copyable_attribute_names.inject({}) { |attrs, name| attrs[name] = send(name); attrs }
  end

  private

  def extract_last_unit_value(value)
    value.split(%r{\s?-\s?}).last.strip
  end

  def copyable_attribute_names
    %w[
      summary
      notes
      week
      day
      discipline_name
      mode_name
      zone_name
      period_name
      distance
      duration
      ability_names
      strength_ability_names
    ]
  end

  def discipline_distance_unit
    if discipline_tagging
      discipline_tagging.distance_unit
    else
      'mi'
    end
  end
end
