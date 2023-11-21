class AddStaticToGroups < ActiveRecord::Migration[7.0]
  def change
    add_column :groups, :static, :boolean
  end
end
