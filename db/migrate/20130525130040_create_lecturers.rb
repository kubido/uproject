class CreateLecturers < ActiveRecord::Migration[4.2]
  def up
    create_table :lecturers do |t|
      t.integer   :user_id
      t.timestamps
    end
  end

  def down
    drop_table :lecturers
  end
end
