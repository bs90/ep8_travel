class CreateAdmins < ActiveRecord::Migration[7.1]
  def change
    create_table :admins do |t|
      t.string :email
      t.string :name
      t.string :password_digest
      t.string :refresh_token

      t.timestamps
    end
  end
end
