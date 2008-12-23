class CreateMemories < ActiveRecord::Migration
  def self.up
    create_table :memories do |t|
      t.string :model
      t.string :serialnumber
      t.timestamps
    end
  end

  def self.down
    drop_table :memories
  end
end
