class Place < ActiveRecord::Base

  has_many :computer, :dependent => :nullify
  has_many :printer, :dependent => :nullify
  has_many :screen, :dependent => :nullify

  #################################################
  # VALIDATIONS
  validates_uniqueness_of :title
  validates_presence_of :title, :description, :message => 'is required'
  validates_size_of :title, :within => 1..100


  #################################################
  # Named Scope
  named_scope :departments, :conditions => ["description = 'department'"]
  named_scope :offices, :conditions => ["description = 'office'"]
  named_scope :rooms, :conditions => ["description = 'room'"]
  named_scope :stores, :conditions => ["description = 'store'"]

end
