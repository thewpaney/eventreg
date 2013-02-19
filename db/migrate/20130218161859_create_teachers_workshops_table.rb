class CreateTeachersWorkshopsTable < ActiveRecord::Migration
  def up
    create_table :teachers_workshops, :id => false do |t|
      t.references :teacher
      t.references :workshop
    end
    add_index :teachers_workshops, [:teacher_id, :workshop_id]
    add_index :teachers_workshops, [:workshop_id, :teacher_id]    
  end

  def down
    drop_table :teachers_workshops
  end
end
