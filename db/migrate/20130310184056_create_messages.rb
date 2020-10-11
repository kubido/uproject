class CreateMessages < ActiveRecord::Migration[4.2]
  def up
    create_table :messages do |t|
      t.integer   :user_id
      t.string    :message
      t.timestamps
    end
  end

  def down
  end
end
