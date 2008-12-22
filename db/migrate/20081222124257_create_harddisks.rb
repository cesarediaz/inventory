class CreateHarddisks < ActiveRecord::Migration
  def self.up
    create_table :harddisks do |t|
      t.string :model
      t.string :serialnumber
      t.integer :computer_id

      t.timestamps
    end
  end

  def self.down
    drop_table :harddisks
  end
end
