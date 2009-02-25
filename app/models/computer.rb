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
  named_scope :list_for_place, lambda { |*args| { :conditions => ['place_id = ?', args]}}
  named_scope :list_for_place_are_not_part_a_workstation, lambda { |*args| {
      :conditions => ['place_id = ? and is_part_of_a_workstation = ?', args, false]}}
  named_scope :list_for_place_as_part_a_workstation, lambda { |*args| {
      :conditions => ['place_id = ? and is_part_of_a_workstation = ?', args, true]}}
  named_scope :in_workstation,  lambda { |*args| {
      :conditions => ['id = ? and is_part_of_a_workstation = ?', args, true]}}
end
