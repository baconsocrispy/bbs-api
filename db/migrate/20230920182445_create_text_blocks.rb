class CreateTextBlocks < ActiveRecord::Migration[7.0]
  def change
    create_table :text_blocks do |t|
      t.string :title
      t.string :text, null: false
      t.integer :order

      t.timestamps
    end
    add_reference :text_blocks, :product, null: false, foreign_key: true
  end
end
