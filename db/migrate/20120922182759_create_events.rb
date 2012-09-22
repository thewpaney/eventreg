class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.column :name, :string
      t.column :sessionid, :number
      t.column :maxcapacity, :number
      t.column :currentcapacity, :number
    end
  end
end
