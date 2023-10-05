class CreateProductGroupings < ActiveRecord::Migration[7.0]
  def change
    create_table :product_groupings do |t|
      t.references :product, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
