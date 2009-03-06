class Cd < ActiveRecord::Base
  belongs_to :computer
  belongs_to :mark
  has_one :bill

  #################################################
  # VALIDATIONS
  validates_uniqueness_of :serialnumber
  validates_presence_of :serialnumber, :model

end
