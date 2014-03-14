class ItemsSite < ActiveRecord::Base
  belongs_to :site
  attr_accessible :lat, :lng, :speed, :ts, :site_id, :accuracy, :altitude, :bearing
end
