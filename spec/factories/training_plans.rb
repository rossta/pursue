# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :training_plan do
    title "Your Best Half-Ironman"
    summary "Prepare to set your personal best at the half-iron distance"
    creator { build(:user) }
  end
end
