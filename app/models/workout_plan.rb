class WorkoutPlan < ActiveRecord::Base
  belongs_to :training_plan

  enum day: %w[ Monday Tuesday Wednesday Thursday Friday Saturday Sunday ]

  validates :week, numericality: { greater_than: 0, less_than_or_equal_to: :max_week }

  def self.day_names
    days.keys
  end

  def max_week
    training_plan.max_week
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
end
