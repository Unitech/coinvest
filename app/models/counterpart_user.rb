class CounterpartUser < ActiveRecord::Base
  validates_presence_of :user_id
  validates_presence_of :counterpart_id
  
  has_one :user
  has_one :counterpart
end

