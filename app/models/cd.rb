class Cd < ActiveRecord::Base
  belongs_to :computer

  #################################################
  # VALIDATIONS
  validates_uniqueness_of :serialnumber
  validates_presence_of :serialnumber, :model

end
