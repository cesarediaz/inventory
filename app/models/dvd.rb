class Dvd < ActiveRecord::Base
  belongs_to :computer
  belongs_to :mark
  belongs_to :model
  has_one :bill


  #################################################
  # VALIDATIONS
  validates_presence_of :model_id, :mark_id


  def description_model
    "#{self.mark.name} #{self.model.description}" unless self.model_id.nil?
  end
end
