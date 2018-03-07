class CreateUsers < ActiveRecord::Migration[5.1]
  def self.up
    create_table :users do |t|
      t.integer :numer
      t.string :full
      t.string :division
      t.integer :year
      t.string :email
      t.string :prefix
      t.string :rw
      t.string :rw_number
      t.string :rw_teacher
      t.string :advisement
      t.string :advisement_name
      t.string :special
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :users
  end
end
