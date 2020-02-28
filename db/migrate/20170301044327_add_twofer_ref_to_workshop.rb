class AddTwoferRefToWorkshop < ActiveRecord::Migration[6.0]
  def change
    change_table :workshops do |t|
      t.integer :twofer_ref
    end
  end
end
