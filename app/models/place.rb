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
  named_scope :departments, :select => 'title, id, description',
  :conditions => ["description = 'department'"]

  named_scope :offices, :select => 'title, id, description',
  :conditions => ["description = 'office'"], :order => 'title'

  named_scope :rooms, :select => 'title, id, description',
  :conditions => ["description = 'room'"], :order => 'title'

  named_scope :classrooms, :select => 'title, id, description' ,
  :conditions => ["description = 'classroom'"], :order => 'title'

  named_scope :stores, :select => 'title, id, description',
  :conditions => ["description = 'store'"], :order => 'title'

end
