class ChangeCompanyAddressData < ActiveRecord::Migration
  def self.up
    add_column :companies, :city, :string
    add_column :companies, :street, :string
    add_column :companies, :number, :string
    add_column :companies, :country, :string
    remove_column :companies, :address
  end

  def self.down
    remove_column :companies, :city
    remove_column :companies, :street
    remove_column :companies, :number
    remove_column :companies, :country
    add_column :companies, :address, :string
  end
end

