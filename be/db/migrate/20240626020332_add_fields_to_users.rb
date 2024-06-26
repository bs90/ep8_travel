class AddFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :password_digest, :string
    add_column :users, :is_admin, :boolean, default: false
    rename_column :users, :avatar, :picture
  end
end
