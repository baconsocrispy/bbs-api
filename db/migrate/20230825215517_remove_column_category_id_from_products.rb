class RemoveColumnCategoryIdFromProducts < ActiveRecord::Migration[7.0]
  def change
    remove_column :products, :category_id
  end
end
