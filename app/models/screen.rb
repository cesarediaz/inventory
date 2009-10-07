class Screen < ActiveRecord::Base
  before_destroy :delete_workstation_before_destroy

  ################################################
  # RELATIONSHIPS
  belongs_to :place
  belongs_to :mark
  belongs_to :model
  has_one :bill

  #################################################
  # VALIDATIONS
  validates_presence_of :model_id, :mark_id, :place_id

  #################################################
  # Named Scope
  named_scope :list_for_place, lambda { |*args| { :conditions => ['place_id = ?', args]}}
  named_scope :list_for_place_are_not_part_a_workstation, lambda { |*args| {
      :conditions => ['place_id = ? and is_part_of_a_workstation = ?', args, false]}}
  named_scope :list_for_place_as_part_a_workstation, lambda { |*args| {
      :conditions => ['place_id = ? and is_part_of_a_workstation = ?', args, true]}}


  def description_model
    "#{self.mark.name} #{self.model.description}" unless self.model_id.nil?
  end

  #This must delete workstation belong to this computer that will be deleted too
  def delete_workstation_before_destroy
    if self.is_part_of_a_workstation
      @workstation = Workstation.find(:first, :conditions => ['screen_id = ?', self.id])
      @workstation.destroy
    end
  end
end
