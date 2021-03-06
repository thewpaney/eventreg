class CreateStudents < ActiveRecord::Migration
  def up
    create_table :students do |t|
      t.integer :number
      t.string :full
      t.string :gender
      t.string :grade
      t.string :year
      t.string :email
      t.string :prefix
      t.string :rw
      t.string :rw_number
      t.string :rw_teacher
      t.string :advisement
    end
  end

  def down
    drop_table :students
  end
end
