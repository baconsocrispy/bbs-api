class CreateHeroContents < ActiveRecord::Migration[7.0]
  def change
    create_table :hero_contents do |t|
      t.string :button_text, null: false
      t.string :header_text, null: false
      t.string :href, null: false

      t.timestamps
    end
  end
end
