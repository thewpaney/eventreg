class AddAdvisementTeacherToStudents < ActiveRecord::Migration[6.0]
  def change
    change_table :students do |t|
      t.string :advisement_name
    end
  end
end
