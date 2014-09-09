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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :workout_plan do
    summary "Run 5 miles"
    notes "Go easy"

    week { (1..36).to_a.sample }
    day { WorkoutPlan.day_names.sample }
  end
end
