class CreateTrainingPlans < ActiveRecord::Migration
  def change
    create_table :training_plans do |t|
      t.string :title, null: false
      t.string :summary
      t.references :creator, index: true, null: false

      t.timestamps
    end

    add_foreign_key :training_plans, :users, column: :creator_id
  end
end
