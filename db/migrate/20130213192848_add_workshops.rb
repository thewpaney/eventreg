class AddWorkshops < ActiveRecord::Migration
  def up
    create_table :workshops do |t|
      t.string :name
      t.string :presentor
      t.text :description
      t.integer :session
      t.string :tlimit
      t.string :slimit
      t.string :room
      t.integer :ttaken
      t.integer :staken
    end
  end

  def down
    drop_table :workshops
  end
end
