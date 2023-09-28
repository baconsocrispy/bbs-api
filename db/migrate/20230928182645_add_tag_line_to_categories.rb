class AddTagLineToCategories < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :tag_line, :string
  end
end
