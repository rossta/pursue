class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.date :occurs_on

      t.timestamps
    end
  end
end
