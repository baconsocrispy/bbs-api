class RemoveProductCategories < ActiveRecord::Migration[7.0]
  def change
    drop_table :product_categories
  end
end
