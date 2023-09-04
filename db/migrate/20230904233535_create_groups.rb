class CreateGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :groups do |t|
      t.string :name
      t.string :short_description
      t.string :slug

      t.timestamps
    end

    add_reference :groups, :category, foreign_key: true
  end
end
