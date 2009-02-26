class AddIsAdminToUserTable < ActiveRecord::Migration
  def self.up
    add_column :users, :is_admin, :boolean, :default => false

    execute "UPDATE users SET is_admin = 't' WHERE login='admin'"
  end

  def self.down
    remove_column :users, :is_admin
  end
end

