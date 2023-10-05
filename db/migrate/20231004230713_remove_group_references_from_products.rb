class RemoveGroupReferencesFromProducts < ActiveRecord::Migration[7.0]
  def change
    change_table :products do |t|
      t.remove_references :group
    end
  end
end
