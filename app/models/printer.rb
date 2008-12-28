class Printer < ActiveRecord::Base
  belongs_to :mark


  #################################################
  # VALIDATIONS
  validates_uniqueness_of :serialnumber
  validates_presence_of :serialnumber, :model
end
