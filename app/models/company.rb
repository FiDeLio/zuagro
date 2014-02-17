class Company < ActiveRecord::Base
  attr_accessible :name, :phone, :activated
end
