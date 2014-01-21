class CreateStudentsWorkshopsTable < ActiveRecord::Migration
  def up
    create_table :students_workshops do |t|
      t.references :student
      t.references :workshop
    end
    add_index :students_workshops, [:student_id, :workshop_id]
    add_index :students_workshops, [:workshop_id, :student_id]
  end
  
  def down
    drop_table :students_workshops
  end
end
