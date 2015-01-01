class AddColumnsToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :distance, :string, default: '0 m'
    add_column :entries, :duration, :string, default: '0 s'
  end
end
