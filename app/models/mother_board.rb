class MotherBoard < ActiveRecord::Base
  belongs_to :computer
  belongs_to :mark
  has_one :bill


  #################################################
  # VALIDATIONS
  validates_uniqueness_of :serialnumber
  validates_presence_of :model, :serialnumber, :mark_id
  validates_size_of :serialnumber, :within => 8..15
end
