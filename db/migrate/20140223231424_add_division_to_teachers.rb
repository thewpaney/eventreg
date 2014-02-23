class AddDivisionToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :division, :string
  end
end
