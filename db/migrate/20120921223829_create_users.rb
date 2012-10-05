class CreateUsers < ActiveRecord::Migration

  def change
    create_table :users do |t|
      t.integer :student_id
      t.string :login
      t.string :first
      t.string :last
      t.integer :grade
      t.references :event
    end

    add_index :users, :student_id, unique: true
    add_index :users, :login, unique: true
  end
end
