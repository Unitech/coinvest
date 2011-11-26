class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  validates_presence_of :content
  validates_presence_of :user
  validates_presence_of :project
end
