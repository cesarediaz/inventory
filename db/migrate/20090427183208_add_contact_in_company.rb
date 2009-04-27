class AddContactInCompany < ActiveRecord::Migration
  def self.up
    add_column :companies, :contact, :text
  end

  def self.down
    remove_column :companies, :contact
  end
end
