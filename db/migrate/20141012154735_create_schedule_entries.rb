class CreateScheduleEntries < ActiveRecord::Migration
  def change
    create_table :schedule_entries do |t|
      t.references :schedule, index: true
      t.references :entry, index: true
      t.date :occurs_on

      t.timestamps
    end
  end
end
