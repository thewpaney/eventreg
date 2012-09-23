class CreateUsers < ActiveRecord::Migration

  def change
    create_table :users do |t|
      t.string :name
      t.integer :student_id
      t.integer :event_id
      t.references :event
    end
  end

end
