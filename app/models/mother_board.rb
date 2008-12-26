class MotherBoard < ActiveRecord::Base
  belongs_to :computer
  belongs_to :mark


  #################################################
  # VALIDATIONS
  validates_uniqueness_of :serialnumber
  validates_presence_of :title, :serialnumber
  validates_size_of :serialnumber, :within => 8..15
end
