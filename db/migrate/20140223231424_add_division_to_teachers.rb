class AddDivisionToTeachers < ActiveRecord::Migration[6.0]
  def change
    add_column :teachers, :division, :string
  end
end
