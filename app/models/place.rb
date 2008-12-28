class Place < ActiveRecord::Base

  has_many :computer, :dependent => :nullify

  #################################################
  # VALIDATIONS
  validates_uniqueness_of :title
  validates_presence_of :title, :description
end
