class Site < ActiveRecord::Base
  belongs_to :user
  attr_accessible :name, :activated, :comments, :user_id
end
