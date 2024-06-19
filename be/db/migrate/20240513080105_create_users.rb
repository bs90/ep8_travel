class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.text :avatar
      t.string :refresh_token

      t.timestamps
    end
  end
end
