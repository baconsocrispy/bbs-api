class AddSortOrderToGroups < ActiveRecord::Migration[7.0]
  def change
    add_column :groups, :sort_order, :integer
  end
end
