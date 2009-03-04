class Company < ActiveRecord::Base
  #################################################
  # VALIDATIONS
  validates_uniqueness_of :name
  validates_presence_of :name, :address, :phone, :fax, :email
end
