class Harddisk < ActiveRecord::Base
  belongs_to :computer
  belongs_to :mark
  belongs_to :model
  has_one :bill


  #################################################
  # VALIDATIONS
  validates_uniqueness_of :serialnumber
  validates_presence_of :serialnumber, :size, :mark_id, :model_id
  validates_numericality_of   :size
end
