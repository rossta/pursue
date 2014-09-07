class CreateWorkoutPlans < ActiveRecord::Migration
  def change
    create_table :workout_plans do |t|
      t.string :summary
      t.text :notes
      t.integer :day
      t.integer :week
      t.references :training_plan, index: true, null: false

      t.timestamps
    end
  end
end
