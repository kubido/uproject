class CreateProfiles < ActiveRecord::Migration[4.2]
  def up
    create_table :profiles do |t|
      t.integer     :user_id
      t.integer     :angkatan
      t.integer     :semester
      t.string      :nim
      t.timestamps
    end
  end

  def down
    drop_table :profiles
  end
end
