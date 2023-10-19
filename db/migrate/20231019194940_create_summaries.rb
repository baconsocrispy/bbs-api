class CreateSummaries < ActiveRecord::Migration[7.0]
  def change
    create_table :summaries do |t|
      t.string :header, null: false
      t.string :copy, null: false

      t.timestamps
    end
  end
end
