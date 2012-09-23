class AddEventToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :sessionid
    remove_column :events, :currentcapacity
    remove_column :events, :sessionid     
  end
end
