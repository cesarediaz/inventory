class CreateMotherBoards < ActiveRecord::Migration
  def self.up
    create_table :mother_boards do |t|
      t.string :title
      t.string :serialnumber

      t.timestamps
    end
  end

  def self.down
    drop_table :mother_boards
  end
end
