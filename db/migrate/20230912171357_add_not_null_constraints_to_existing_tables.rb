class AddNotNullConstraintsToExistingTables < ActiveRecord::Migration[7.0]
  def change
    change_column :products, :name, :string, null: false
    change_column :categories, :slug, :string, null: false
    change_column :groups, :name, :string, null: false
    change_column :groups, :slug, :string, null: false
    change_column :groups, :category_id, :bigint, null: false
    add_index :categories, :name, unique: true
    add_index :groups, :name, unique: true
  end
end
