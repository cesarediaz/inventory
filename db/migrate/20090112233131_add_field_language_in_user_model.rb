class AddFieldLanguageInUserModel < ActiveRecord::Migration
  def self.up
    add_column :users, :language, :text, :default => 'en'
  end

  def self.down
    remove_column :users, :language
  end
end
