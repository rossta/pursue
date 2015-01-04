class AddSchedulableToEntries < ActiveRecord::Migration
  def change
    change_table(:entries) do |t|
      t.column :occurs_on, :date
      t.references :schedulable, polymorphic: true, index: true
    end
  end
end
