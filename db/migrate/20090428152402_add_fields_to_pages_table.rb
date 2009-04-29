class AddFieldsToPagesTable < ActiveRecord::Migration
  def self.up
    add_column :pages, :frontend, :boolean, :default => false
  end

  def self.down
    remove_column :pages, :frontend
  end
end
