class Printer < ActiveRecord::Base
  belongs_to :mark
  belongs_to :place

  #################################################
  # VALIDATIONS
  validates_uniqueness_of :serialnumber
  validates_presence_of :serialnumber, :model

  #################################################
  # Named Scope
  named_scope :list_for_place, lambda { |*args| { :conditions => ['place_id = ?', args]}}
  named_scope :list_for_place_are_not_part_a_workstation, lambda { |*args| {
      :conditions => ['place_id = ? and is_part_of_a_workstation = ?', args, false]}}
  named_scope :list_for_place_as_part_a_workstation, lambda { |*args| {
      :conditions => ['place_id = ? and is_part_of_a_workstation = ?', args, true]}}
end
