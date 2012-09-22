class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.column :name, :string
      t.column :session1, :number
      t.column :session2, :number
    end
  end

  def change
    create_table :users do |t|
      t.column :name, :string
      t.column :session1, :number
      t.column :session2, :number
    end
  end

  def self.down
    drop_table :users
  end

end
