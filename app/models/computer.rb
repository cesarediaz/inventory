class Computer < ActiveRecord::Base

  has_one :mother_board ,  :dependent => :nullify
  has_many :harddisk, :dependent => :nullify
  has_many :memory, :dependent => :nullify
  has_many :cd, :dependent => :nullify
  has_many :dvd, :dependent => :nullify

  belongs_to :place


  #################################################
  # VALIDATIONS
  validates_uniqueness_of :name, :ip, :mac
  validates_presence_of :name, :ip, :mac
  validates_size_of :ip, :within => 8..15
  validates_format_of :ip, :with => /^\b(?:\d{1,3}\.){3}\d{1,3}\b/i
  validates_format_of :mac, :with => /^([0-9a-f]{2}([:-]|$)){6}$/i

  #################################################
  # Named Scope
  named_scope :available, :conditions => ['available = ?', true]
  named_scope :unavailable, :conditions => ['available = ?', false]

end
