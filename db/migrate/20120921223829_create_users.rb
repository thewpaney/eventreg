class CreateUsers < ActiveRecord::Migration

  def change
    create_table :users do |t|
      t.integer :student_id
      t.string :firstname
      t.string :lastname
      t.integer :grade
      t.string :login
      t.string :email
      t.integer :event_id
      t.references :event
    end
  end

end
