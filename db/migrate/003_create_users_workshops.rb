class CreateUsersWorkshops < ActiveRecord::Migration[5.1]
  def self.up
    create_table :users_workshops do |t|
      t.integer :user_id
      t.integer :workshop_id
    end
  end

  def self.down
    drop_table :users_workshops
  end
end
