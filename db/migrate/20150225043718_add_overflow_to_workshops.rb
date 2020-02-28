class AddOverflowToWorkshops < ActiveRecord::Migration[6.0]
  def change
    change_table :workshops do |t|
      t.integer :overflow
    end
  end
end
