class CreateScreens < ActiveRecord::Migration
  def self.up
    create_table :screens do |t|
      t.string :model
      t.string :serialnumber
      t.integer :mark_id

      t.timestamps
    end
  end

  def self.down
    drop_table :screens
  end
end
