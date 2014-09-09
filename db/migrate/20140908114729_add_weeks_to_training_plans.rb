class AddWeeksToTrainingPlans < ActiveRecord::Migration
  def change
    change_table :training_plans do |t|
      t.integer :total_weeks
      t.integer :peak_week
    end
  end
end
