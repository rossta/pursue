class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.references :tag, index: true, polymorphic: true

      t.references :taggable, index: true, polymorphic: true
      t.references :tagger, index: true, polymorphic: true

      # Limit is created to prevent MySQL error on index
      # length for MyISAM table type: http://bit.ly/vgW2Ql
      t.string :context, limit: 128

      t.datetime :created_at
    end

    add_index :taggings, [:taggable_id, :taggable_type, :context]
    add_index :taggings,
      [:tag_id, :taggable_id, :taggable_type, :context, :tagger_id, :tagger_type],
      unique: true, name: 'taggings_idx'
  end
end
