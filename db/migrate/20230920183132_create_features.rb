class CreateFeatures < ActiveRecord::Migration[7.0]
  def change
    create_table :features do |t|
      t.string :highlight
      t.string :text, null: false
      t.integer :order

      t.timestamps
    end
    add_reference :features, :product, null: false, foreign_key: true
  end
end
