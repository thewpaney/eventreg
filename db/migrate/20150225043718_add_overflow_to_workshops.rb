class AddOverflowToWorkshops < ActiveRecord::Migration
  def change
    change_table :workshops do |t|
      t.integer :overflow
    end
  end
end
