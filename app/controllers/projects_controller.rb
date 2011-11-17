# -*- coding: utf-8 -*-
class ProjectsController < ApplicationController
  before_filter :authenticate_user!, :only => ['new', 'edit']
  # GET /projects
  # GET /projects.json
  def index
    ord = 'created_at DESC'
    cond = ['validated = ?', true]

    cond[0] += ' and date_end_wish > ?'
    cond << Date.today

    case params[:type]
    when 'entreprise'
      cond[0] += ' and capital_stock_type = ?'
      cond << true
    when 'projets'
      cond[0] += ' and personalized_reward = ?'
      cond << true
    when 'finished'
      cond = ['validated = ? and date_end_wish < ? ', true, Date.today]
    end

    case params[:sort]
    when 'finishing'
      ord = 'date_end_wish ASC'
    when 'finished'
      cond = ['validated = ? and date_end_wish < ? ', true, Date.today]
    when 'recent'
      ord = 'date_end_wish DESC'
    end


    @projects = Project.paginate :page => params[:page], :per_page => 6, :order => ord, :conditions => cond

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

  def show
    @project = Project.find_by_title(params[:proj_name])
    
    @users = []

    @project.counterparts.each do |c| 
      c.counterpart_users.each do |g|
        @users << User.find(g.user_id)
      end
    end
    # @investor = @project.get_investor
    render :layout => 'show_project_layout'
  end

  def invest
  end

  def buy_counterpart
    @counterpart = Counterpart.find_by_id(params[:id])
  end

  def confirm_counterpart
    @counterpart = Counterpart.find_by_id(params[:id])
    @new = CounterpartUser.new(:counterpart_id => @counterpart.id, :user_id => current_user.id)

    user = User.find_by_id(current_user.id)

    if (user.remove_credits(@counterpart.bearing) == false)
      redirect_to @counterpart.project.get_url, :notice => 'Vous n\'avez pas assez de crédits'
      return 
    end

    CreditHistoric.create(:historic_type => 'depense', :value => @counterpart.bearing, :user_id => user.id)
    
    if @new.save
      respond_to do |format|
        format.html
      end
    else
      redirect_to :buy_counterpart, :notice => 'Vous n\'avez pas assez de crédits'
    end    
  end
end
