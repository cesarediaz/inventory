class Memory < ActiveRecord::Base
  belongs_to :computer
  belongs_to :mark


  #################################################
  # VALIDATIONS
  validates_uniqueness_of :serialnumber
  validates_presence_of :serialnumber, :model, :size
  validates_numericality_of   :size
end
