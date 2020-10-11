class ChangeUidToString < ActiveRecord::Migration[4.2]
  def up
    change_column :users, :uid, :string
  end

  def down
    change_column :users, :uid, :integer
  end
end
