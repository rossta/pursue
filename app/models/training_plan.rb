class TrainingPlan < ActiveRecord::Base
  belongs_to :creator, class_name: 'User'

  has_many :workout_plans

  def max_week
    36
  end
end
