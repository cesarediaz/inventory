class Bill < ActiveRecord::Base
  belongs_to  :company
  has_many :screens, :dependent => :nullify
  has_many :printers, :dependent => :nullify
  has_many :computers, :dependent => :nullify
  has_many :mother_boards, :dependent => :nullify
  has_many :harddisks, :dependent => :nullify
  has_many :memories, :dependent => :nullify
  has_many :cds, :dependent => :nullify
  has_many :dvds, :dependent => :nullify

  def company_bill
    "#{self.company.name.upcase} #{code}"
  end


  #################################################
  # Named Scope
  named_scope :list_for_company, lambda { |*args| { :conditions => ['company_id = ?', args]}}

end
