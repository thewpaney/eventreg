class AddTeachers < ActiveRecord::Migration
  def up
    create_table :teachers do |t|
      t.string :number
      t.string :name
      t.string :email
    end
  end

  def down
    drop_table :teachers
  end
end
