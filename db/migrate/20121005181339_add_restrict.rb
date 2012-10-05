class AddRestrict < ActiveRecord::Migration
  def up
    add_column :events, :restrict, :integer
  end
  
  def down
    remove_column :events, :restrict, :integer
  end
end
