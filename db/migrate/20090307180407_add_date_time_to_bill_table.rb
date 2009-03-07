class AddDateTimeToBillTable < ActiveRecord::Migration
  def self.up
    add_column :bills, :date, :datetime
  end

  def self.down
    remove_column :bills ,:date
  end
end
