class Place < ActiveRecord::Base

  has_many :computer, :dependent => :nullify

  #################################################
  # VALIDATIONS
  validates_uniqueness_of :title
  validates_presence_of :title, :description

  #################################################
  # Named Scope
  named_scope :departments, :conditions => ["description = 'department'"]
  named_scope :offices, :conditions => ["description = 'office'"]
  named_scope :rooms, :conditions => ["description = 'room'"]
  named_scope :stores, :conditions => ["description = 'store'"]

end
