class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.column :name, :string
      t.column :sessionid, :number
    end
  end

  def change
    create_table :users do |t|
      t.column :name, :string
      t.column :sessionid, :number
    end
  end

  def self.down
    drop_table :users
  end

end
