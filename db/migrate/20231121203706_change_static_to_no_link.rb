class ChangeStaticToNoLink < ActiveRecord::Migration[7.0]
  def change
    rename_column :groups, :static, :no_link
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
