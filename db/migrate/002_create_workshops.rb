class CreateWorkshops < ActiveRecord::Migration[5.1]
  def self.up
    create_table :workshops do |t|
      t.string :name
      t.string :presenter
      t.string :description
      t.integer :session
      t.integer :tlimit
      t.integer :slimit
      t.string :room
      t.integer :ttaken
      t.integer :staken
      t.integer :percentage
      t.integer :overflow
      t.integer :twofer_ref
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :workshops
  end
end
