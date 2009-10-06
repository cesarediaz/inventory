class Memory < ActiveRecord::Base
  belongs_to :computer
  belongs_to :mark
  belongs_to :model
  has_one :bill



  #################################################
  # VALIDATIONS
  validates_presence_of :size, :mark_id, :model_id
  validates_numericality_of   :size

  def description_model
    "#{self.mark.name} #{self.model.description}" unless self.model_id.nil?
  end
end
