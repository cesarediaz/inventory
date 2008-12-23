class CreateCds < ActiveRecord::Migration
  def self.up
    create_table :cds do |t|
      t.string :model
      t.string :serialnumber
      t.boolean :writable
      t.integer :computer_id

      t.timestamps
    end
  end

  def self.down
    drop_table :cds
  end
end
