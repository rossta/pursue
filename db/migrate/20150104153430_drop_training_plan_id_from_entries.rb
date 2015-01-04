class DropTrainingPlanIdFromEntries < ActiveRecord::Migration
  def up
    remove_column :entries, :training_plan_id
  end

  def down
    add_column :entries, :training_plan_id, :integer
  end
end
