class Bill < ActiveRecord::Base
  has_and_belongs_to_many :companies
  has_many :screens
  has_many :printers

  has_many :mother_boards
  has_many :harddisks
  has_many :memories
  has_many :cds
  has_many :dvds
end
