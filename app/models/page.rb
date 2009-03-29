class Page < ActiveRecord::Base
  #################################################
  # VALIDATIONS
  validates_presence_of :name, :permalink, :content
end
