# == Schema Information
#
# Table name: training_plans
#
#  id          :integer          not null, primary key
#  title       :string(255)      not null
#  summary     :string(255)
#  creator_id  :integer          not null
#  created_at  :datetime
#  updated_at  :datetime
#  total_weeks :integer
#  peak_week   :integer
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :training_plan do
    title "Your Best Half-Ironman"
    summary "Prepare to set your personal best at the half-iron distance"
    creator { build(:user) }
    total_weeks 36
    peak_week 28
  end
end
