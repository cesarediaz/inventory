class CreateDvds < ActiveRecord::Migration
  def self.up
    create_table :dvds do |t|
      t.string :model
      t.string :serialnumber
      t.boolean :writable
      t.integer :computer_id

      t.timestamps
    end
  end

  def self.down
    drop_table :dvds
  end
end
