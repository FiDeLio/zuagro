class Instance < ActiveRecord::Base
  belongs_to :company
  belongs_to :device
  belongs_to :user
  attr_accessible :user_id, :json, :device, :version
end
