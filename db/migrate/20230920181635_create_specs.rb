class CreateSpecs < ActiveRecord::Migration[7.0]
  def change
    create_table :specs do |t|
      t.string :category, null: false
      t.string :text, null: false

      t.timestamps
    end
    add_reference :specs, :product, null: false, foreign_key: true
  end
end
