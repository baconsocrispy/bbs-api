class RemoveImageUrlFromCategories < ActiveRecord::Migration[7.0]
  def change
    remove_column :categories, :image_url
  end
end
