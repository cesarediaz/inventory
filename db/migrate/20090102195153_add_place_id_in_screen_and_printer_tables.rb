class AddPlaceIdInScreenAndPrinterTables < ActiveRecord::Migration
  def self.up
    add_column :printers, :place_id, :integer
    add_column :screens, :place_id, :integer
  end

  def self.down
    remove_column  :printers, :place_id
    remove_column  :screens, :place_id
  end
end
