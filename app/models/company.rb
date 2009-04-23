class Company < ActiveRecord::Base
  acts_as_mappable

  has_many :bills, :dependent => :nullify

  #################################################
  # VALIDATIONS
  validates_uniqueness_of :name
  validates_numericality_of :number
  validates_presence_of :name, :phone, :email, :street, :number, :city, :country
  validates_format_of :email, :with =>
    %r{^(?:[_a-z0-9-]+)(\.[_a-z0-9-]+)*@([a-z0-9-]+)(\.[a-zA-Z0-9\-\.]+)*(\.[a-z]{2,4})$}i

  def complete_address
    "#{street} #{number}, #{city}, #{country}"
  end
end
