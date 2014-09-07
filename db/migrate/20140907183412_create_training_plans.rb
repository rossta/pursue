class CreateTrainingPlans < ActiveRecord::Migration
  def change
    create_table :training_plans do |t|
      t.string :title, null: false
      t.string :summary
      t.references :creator, index: true, null: false

      t.timestamps
    end
  end
end
