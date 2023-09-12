class AddSlugToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :slug, :string, null: false
  end
end
