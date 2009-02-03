class Mark < ActiveRecord::Base

  has_many :mother_board, :dependent => :nullify
  has_many :harddisk, :dependent => :nullify
  has_many :memory, :dependent => :nullify
  has_many :cd, :dependent => :nullify
  has_many :dvd, :dependent => :nullify

  #################################################
  # VALIDATIONS
  validates_uniqueness_of :name
  validates_presence_of :name
end
