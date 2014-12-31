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

  # has_one :period_tagging, as: :taggable, dependent: :destroy, class_name: "Tagging::Period"
  # has_one :period, through: :period_tagging, source: :tag, class_name: "Tag"
  #
  # has_one :discipline_tagging, as: :taggable, dependent: :destroy, class_name: "Tagging::Discipline"
  # has_one :discipline, through: :discipline_tagging, source: :tag, class_name: "Tag"
  #
  # has_many :ability_taggings, as: :taggable, dependent: :destroy, class_name: "Tagging::Ability"
  # has_many :abilities, through: :ability_taggings, source: :tag, class_name: "Tag"
  #
  # has_one :strength_ability_tagging, as: :taggable, dependent: :destroy, class_name: "Tagging::StrengthAbility"
  # has_one :strength_ability, through: :strength_ability_tagging, source: :tag, class_name: "Tag"
  #
  # has_one :zone_tagging, as: :taggable, dependent: :destroy, class_name: "Tagging::Zone"
  # has_one :zone, through: :zone_tagging, source: :tag, class_name: "Tag"
  #
  # def discipline_name
  # delegate :name, to: :discipline, allow_nil: true, prefix: true
  #
  # def discipline_name=(name)
  #   self.discipline = Tag.find_or_create_by(name: name)
  # end
  #
  # # def period_name
  # delegate :name, to: :period, allow_nil: true, prefix: true
  #
  # def period_name=(name)
  #   self.period = Tag.find_or_create_by(name: name)
  # end

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
    "Week #{week}"
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
