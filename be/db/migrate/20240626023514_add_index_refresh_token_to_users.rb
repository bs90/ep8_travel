class AddIndexRefreshTokenToUsers < ActiveRecord::Migration[7.1]
  def change
    add_index :users, :refresh_token
  end
end
