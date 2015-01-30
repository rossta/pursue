class AddThumbnailToTrainingPlans < ActiveRecord::Migration
  def change
    add_column :training_plans, :thumbnail_id, :string
  end
end
