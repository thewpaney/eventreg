class AddWorkshops < ActiveRecord::Migration
  def up
    create_table :workshops do |t|
      t.string :name
      t.string :presentor
      t.string :description
      t.string :first
      t.string :second
      t.string :third
      t.string :tlimit
      t.string :slimit
      t.string :room
    end
  end

  def down
    drop_table :workshops
  end
end
