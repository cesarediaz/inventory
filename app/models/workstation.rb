class Workstation < ActiveRecord::Base
  after_create :update_devices_after_create
  after_destroy :update_devices_after_destroy

  #################################################
  # VALIDATIONS
  validates_uniqueness_of :computer_id, :screen_id, :printer_id
  validates_presence_of :computer_id, :screen_id

  private

  def update_devices_after_create
    @computer = Computer.find(self.computer_id)
    @computer.is_part_of_a_workstation = true
    @computer.save!

    @printer = Printer.find(self.printer_id)
    @printer.is_part_of_a_workstation = true
    @printer.save!

    @screen = Screen.find(self.screen_id)
    @screen.is_part_of_a_workstation = true
    @screen.save!
  end

  def update_devices_after_destroy
    @computer = Computer.find(self.computer_id)
    @computer.is_part_of_a_workstation = false
    @computer.save!

    @printer = Printer.find(self.printer_id)
    @printer.is_part_of_a_workstation = false
    @printer.save!

    @screen = Screen.find(self.screen_id)
    @screen.is_part_of_a_workstation = false
    @screen.save!
  end

end
