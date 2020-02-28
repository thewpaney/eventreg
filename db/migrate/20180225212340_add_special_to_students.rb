class AddSpecialToStudents < ActiveRecord::Migration[6.0]
  def change
    change_table :students do |t|
      t.string :special
    end
  end
end
