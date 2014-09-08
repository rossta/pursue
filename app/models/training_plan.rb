class TrainingPlan < ActiveRecord::Base
  belongs_to :creator, class_name: 'User'

  has_many :workout_plans

  def max_week
    24
  end

  def weeks
    1..24
  end
end
