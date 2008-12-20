class Computer < ActiveRecord::Base

  validates_uniqueness_of :name, :ip, :mac
  validates_presence_of :name, :ip, :mac
  validates_size_of :ip, :within => 8..15
  validates_format_of :ip, :with => /^\b(?:\d{1,3}\.){3}\d{1,3}\b/i

end
