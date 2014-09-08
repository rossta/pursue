# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :workout_plan do
    summary "Run 5 miles"
    notes "Go easy"

    week { (1..36).to_a.sample }
    day { WorkoutPlan.day_names.sample }
  end
end
