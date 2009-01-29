# lib/tasks/populate.rake
namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'

    [Mark, Computer, Screen, Printer, Place, MotherBoard, Memory, Harddisk, Cd, Dvd].each(&:delete_all)

    Mark.populate 100 do |mark|
      mark.name = Populator.words(1..5).titleize
    end

    Place.populate 50 do |place|
      place.title = Populator.words(1..3).titleize
      place.description = ['store', 'room', 'office', 'department']
      Computer.populate 1..10 do |computer|
        computer.place_id = place.id
        computer.available = ['t', 'f']
        computer.name = Populator.words(1..5)
        computer.is_part_of_a_workstation = 'f'
        computer.created_at = 2.years.ago..Time.now
      end
      Screen.populate 1..10 do |screen|
        screen.place_id = place.id
        screen.is_part_of_a_workstation = 'f'
        screen.serialnumber = 1000000..2000000
        screen.model = Populator.words(1..5)
        screen.created_at = 2.years.ago..Time.now
      end
      Printer.populate 1..10 do |printer|
        printer.place_id = place.id
        printer.is_part_of_a_workstation = 'f'
        printer.serialnumber = 1000000..2000000
        printer.model = Populator.words(1..5)
        printer.created_at = 2.years.ago..Time.now
      end
    end
  end
end

