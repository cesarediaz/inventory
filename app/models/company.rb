class Company < ActiveRecord::Base
  has_many :bills, :dependent => :nullify

  #################################################
  # VALIDATIONS
  validates_uniqueness_of :name
  validates_presence_of :name, :address, :phone, :fax, :email
  validates_format_of :email, :with =>
    %r{^(?:[_a-z0-9-]+)(\.[_a-z0-9-]+)*@([a-z0-9-]+)(\.[a-zA-Z0-9\-\.]+)*(\.[a-z]{2,4})$}i
end
