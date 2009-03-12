class ChangeFieldNameInMotherboardsTable < ActiveRecord::Migration
  def self.up
    add_column :mother_boards, :model, :string
    remove_column :mother_boards, :title
  end

  def self.down
    remove_column :mother_boards, :model
    add_column :mother_boards, :title, :string
  end
end
