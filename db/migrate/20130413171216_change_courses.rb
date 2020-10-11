class ChangeCourses < ActiveRecord::Migration[4.2]
  def up
    change_column :courses, :user_id, :integer
    change_column :courses, :lecturer_id, :integer
  end

  def down
    change_column :courses, :user_id, :string
    change_column :courses, :lecturer_id, :string
  end
end
