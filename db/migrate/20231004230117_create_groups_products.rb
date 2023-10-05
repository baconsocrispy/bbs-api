class CreateGroupsProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :groups_products, id: false do |t|
      t.belongs_to :group
      t.belongs_to :product
      
      t.timestamps
    end
  end
end
