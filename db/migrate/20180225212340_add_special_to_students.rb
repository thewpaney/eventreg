class AddSpecialToStudents < ActiveRecord::Migration
  def change
    change_table :students do |t|
      t.string :special
    end
  end
end
