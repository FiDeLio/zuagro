class Fertilizer < ActiveRecord::Base
  attr_accessible  :name, :n_total, :n_nh4, :n_no3, :p2o5, :k20, :cao, :s, :mgo, :b, :zn, :na
end