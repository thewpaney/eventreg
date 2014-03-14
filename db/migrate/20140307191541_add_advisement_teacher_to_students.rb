class AddAdvisementTeacherToStudents < ActiveRecord::Migration
  def change
    change_table :students do |t|
      t.string :advisement_name
    end
  end
end
