class CreateWorkshops < ActiveRecord::Migration[5.1]
  def self.up
    create_table :workshops do |t|
      t.string :name, null: false
      t.string :presenter, null: false
      t.string :description, null: false
      t.integer :session, null: false
      t.integer :tlimit, null: false
      t.integer :slimit, null: false
      t.string :room, null: false
      t.integer :ttaken, null: false
      t.integer :staken, null: false
      t.integer :percentage, null: false
      t.integer :overflow, null: false
      t.integer :twofer_ref, null: false
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :workshops
  end
end
