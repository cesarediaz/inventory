class Bill < ActiveRecord::Base
  belongs_to  :company, :dependent => :delete
  has_many :screens
  has_many :printers
  has_many :computers
  has_many :mother_boards
  has_many :harddisks
  has_many :memories
  has_many :cds
  has_many :dvds

  def company_bill
    "#{self.company.name.upcase} #{code}"
  end
end
