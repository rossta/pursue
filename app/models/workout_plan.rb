# == Schema Information
#
# Table name: workout_plans
#
#  id               :integer          not null, primary key
#  summary          :string(255)
#  notes            :text
#  day              :integer
#  week             :integer
#  training_plan_id :integer          not null
#  created_at       :datetime
#  updated_at       :datetime
#

class WorkoutPlan < ActiveRecord::Base
  belongs_to :training_plan

  has_one :discipline_tagging, as: :taggable, dependent: :destroy, class_name: "Tagging::WorkoutDiscipline"
  has_one :discipline, through: :discipline_tagging, source: :tag, class_name: "Tag"

  enum day: %w[ Monday Tuesday Wednesday Thursday Friday Saturday Sunday ]

  validates :week, numericality: { greater_than: 0, less_than_or_equal_to: :total_weeks }

  def self.day_names
    days.keys
  end

  def total_weeks
    training_plan.total_weeks
  end

  # def discipline_name
  delegate :name, to: :discipline, allow_nil: true, prefix: true

  def discipline_name=(name)
    self.discipline = Tag.find_or_create_by(name: name)
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
