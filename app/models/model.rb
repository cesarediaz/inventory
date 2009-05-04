class Model < ActiveRecord::Base
  belongs_to :mark
  has_many :harddisk
  has_many :memory

  #################################################
  # VALIDATIONS
  validates_uniqueness_of :description
  validates_presence_of :description, :mark_id
  validates_numericality_of :mark_id
end
