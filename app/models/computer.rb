class Computer < ActiveRecord::Base

validates_presence_of	:name, :ip, :mac
end