class AddHighlightToCategories < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :title, :string
    add_column :groups, :highlight, :string
    add_column :products, :highlight, :string
  end
end
