class Role < ActiveRecord::Base
  attr_accessible :name, :activated, :sequence, :open_path
  has_many :users
end
