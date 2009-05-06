class MotherBoard < ActiveRecord::Base
  belongs_to :computer
  belongs_to :mark
  belongs_to :model
  has_one :bill


  #################################################
  # VALIDATIONS
  validates_uniqueness_of :serialnumber
  validates_presence_of :model_id, :serialnumber, :mark_id
  validates_size_of :serialnumber, :within => 8..15

  def description_model
    "#{self.mark.name} #{self.model.description}" unless self.model_id.nil?
  end

end
