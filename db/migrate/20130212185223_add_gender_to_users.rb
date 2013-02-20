class AddGenderToUsers < ActiveRecord::Migration
  
  def up
    add_column :users, :gender, :integer
  end
  
  def down
    remove_column :users, :gender, :integer
  end
  
end
