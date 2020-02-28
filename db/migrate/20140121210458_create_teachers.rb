class CreateTeachers < ActiveRecord::Migration[6.0]
  def up
    create_table :teachers do |t|
      t.string :number
      t.string :name
      t.string :email
      t.string :prefix
    end
  end

  def down
    drop_table :teachers
  end
end
