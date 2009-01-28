class AddFieldPlaceIdInWorkstationsTable < ActiveRecord::Migration
  def self.up
    add_column :workstations, :place_id, :integer, :default => 0
  end

  def self.down
    remove_column :workstations, :place_id
  end
end
