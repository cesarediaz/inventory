class Model < ActiveRecord::Base
  belongs_to :mark
  has_many :harddisk, :dependent => :nullify
  has_many :memory, :dependent => :nullify
  has_many :mother_board, :dependent => :nullify
  has_many :screen, :dependent => :nullify
  has_many :printer, :dependent => :nullify

  #################################################
  # VALIDATIONS
  validates_uniqueness_of :description
  validates_presence_of :description, :mark_id
  validates_numericality_of :mark_id
end
