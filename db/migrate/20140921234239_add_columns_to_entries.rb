class AddColumnsToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :distance, :decimal, default: 0.0
    add_column :entries, :duration, :integer, default: 0
  end
end
