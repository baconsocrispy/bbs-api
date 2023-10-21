class AddBannerTextToSummaries < ActiveRecord::Migration[7.0]
  def change
    add_column :summaries, :banner_text, :string
  end
end
