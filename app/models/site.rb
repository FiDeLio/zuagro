class Site < ActiveRecord::Base
  belongs_to :company
  attr_accessible :company, :name, :activated
end
