class Workstation < ActiveRecord::Base

  #################################################
  # VALIDATIONS
  validates_uniqueness_of :computer_id, :screen_id, :printer_id
  validates_presence_of :computer_id, :screen_id, :printer_id


end
