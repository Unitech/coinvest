require "rubygems"
require "twitter"

class HomeController < ApplicationController
  layout 'home_layout'
  
  def index

    Rails.cache.fetch('@twit', :expires_in => 60.minute) {
    @twit = Twitter.user_timeline("strzel_a").first.text
    }


    id_proj = Project.find( :all, :select => 'id', :conditions => { :capital_stock_type => true } ).map( &:id )
    id_company = Project.find( :all, :select => 'id', :conditions => { :personalized_reward => true } ).map( &:id )

    
    a = (1..3).map { id_proj.delete_at( id_proj.size * rand) }
    b = (1..3).map { id_proj.delete_at( id_proj.size * rand) }
    
    print 'a'*99, a
    print 'b'*99, b
    @project = Project.find(a)
    @enterprise = Project.find(b)
                               
  end
end
