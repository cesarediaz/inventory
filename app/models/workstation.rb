class Workstation < ActiveRecord::Base
  after_create :update_devices_after_create
  after_update :update_devices_after_update
  after_destroy :update_devices_after_destroy

  #################################################
  # VALIDATIONS
  validates_uniqueness_of :computer_id, :screen_id
  validates_presence_of :computer_id, :screen_id

  private

  def update_devices_after_create
    @computer = Computer.find(self.computer_id)
    @computer.is_part_of_a_workstation = true
    @computer.save!

    if not self.printer_id.nil?
      @printer = Printer.find(self.printer_id)
      @printer.is_part_of_a_workstation = true
      @printer.save!
    end

    @screen = Screen.find(self.screen_id)
    @screen.is_part_of_a_workstation = true
    @screen.save!
  end

  def update_devices_after_update
    @computer = Computer.find(self.computer_id)
    @computer.is_part_of_a_workstation = true
    @computer.save!

    if not self.printer_id.nil?
      @printer = Printer.find(self.printer_id)
      @printer.is_part_of_a_workstation = true
      @printer.save!
    end

    @screen = Screen.find(self.screen_id)
    @screen.is_part_of_a_workstation = true
    @screen.save!
  end

  def update_devices_after_destroy
    @computer = Computer.find(self.computer_id)
    @computer.is_part_of_a_workstation = false
    @computer.save!

    if not self.printer_id.nil?
      @printer = Printer.find(self.printer_id)
      @printer.is_part_of_a_workstation = false
      @printer.save!
    end

    @screen = Screen.find(self.screen_id)
    @screen.is_part_of_a_workstation = false
    @screen.save!
  end


  #################################################
  # Named Scope
  named_scope :list_for_place, lambda { |*args| { :conditions => ['place_id = ?', args]}}

end
