class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.string :title
      t.references :training_plan, index: true
      t.references :event, index: true
      t.references :owner, index: true
      t.date :peaks_on
      t.date :starts_on
      t.date :ends_on

      t.timestamps
    end
  end
end
