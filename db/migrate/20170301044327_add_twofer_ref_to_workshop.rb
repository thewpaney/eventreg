class AddTwoferRefToWorkshop < ActiveRecord::Migration
  def change
    change_table :workshops do |t|
      t.integer :twofer_ref
    end
  end
end
