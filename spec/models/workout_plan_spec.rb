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

require 'rails_helper'

RSpec.describe WorkoutPlan, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
