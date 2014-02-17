class Instance < ActiveRecord::Base
  belongs_to :company
  belongs_to :device
  attr_accessible :company, :json, :device, :version
end
