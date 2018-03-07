class CreateUsers < ActiveRecord::Migration[5.1]
  def self.up
    create_table :users do |t|
      t.integer :number, null: false
      t.string :full, null: false
      t.string :division, null: false
      t.integer :year
      t.string :email, null: false
      t.string :prefix, null: false
      t.string :rw
      t.string :rw_number
      t.string :rw_teacher
      t.string :advisement
      t.string :advisement_name
      t.string :special
      t.string :role, null: false
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :users
  end
end
