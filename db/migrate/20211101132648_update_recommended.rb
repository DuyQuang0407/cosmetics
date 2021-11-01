class UpdateRecommended < ActiveRecord::Migration[6.1]
  def change
    remove_column :recommendeds, :recommended_type
    remove_column :recommendeds, :value
    add_column :recommendeds, :content, :text
  end
end
