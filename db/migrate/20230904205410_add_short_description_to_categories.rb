class AddShortDescriptionToCategories < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :short_description, :string
  end
end
