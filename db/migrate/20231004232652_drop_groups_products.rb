class DropGroupsProducts < ActiveRecord::Migration[7.0]
  def change
    drop_table :groups_products
  end
end
