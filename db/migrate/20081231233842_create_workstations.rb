class CreateWorkstations < ActiveRecord::Migration
  def self.up
    create_table :workstations do |t|
      t.integer :printer_id
      t.integer :computer_id, :null => false
      t.integer :screen_id, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :workstations
  end
end
