class AddUidAndAccessTokenToUsers < ActiveRecord::Migration[4.2]
  def up
    add_column :users, :uid, :integer
    add_column :users, :access_token, :string
  end

  def down
    remove_column :users, :uid, :integer
    remove_column :users, :access_token, :string
  end
end
