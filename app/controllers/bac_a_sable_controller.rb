# -*- coding: utf-8 -*-

require 'uri'

class BacASableController < ApplicationController
  before_filter :authenticate_user!, :except => ['choice', 'preview']


  #
  # Pour la page d'édition de projet
  # 
  def edit_project
    @project = Project.where(:id => params[:id]).first
 
    if user_is_owner_of_the_project(@project) == true
      render :layout => 'application_edit_project'
      return
    else
      redirect_to root_path
    end
  end

  def edit_business_plan
    @project = Project.where(:id => params[:id]).first
 
    if user_is_owner_of_the_project(@project) == true
      render :layout => 'application_edit_project'
      return
    else
      redirect_to root_path
    end
  end

  def edit_counterparts
    @counterpart = Counterpart.new
    @project = Project.where(:title => params[:proj_name], :id => params[:id]).first
    #project = Project.find_by_title(params[:proj_name])

    if user_is_owner_of_the_project(@project) == false
      redirect_to root_path
      return 
    end
    
    @counterparts = @project.counterparts
    
    render :layout => 'application_edit_project'
  end

  def submit_project_to_admin
    @project = Project.where(:id => params[:id]).first
    if user_is_owner_of_the_project(@project) == false
      redirect_to root_path
      return 
    end
    new_val = @project.submited ^ true
    @project.update_attributes(:submited => new_val)

    render :json => {:success => true}
  end

  def submit_counterpart    
    @project = Project.where(:id => params[:id]).first
    # @project = Project.find_by_title(params[:proj_name])
    logger.info 'informational message'
    if user_is_owner_of_the_project(@project) == false
      redirect_to root_path
      return 
    end

    params[:counterpart][:project_id] = @project.id
    @counterpart = Counterpart.new(params[:counterpart])

    if @counterpart.save
      flash[:notice] = "Contrepartie bien ajoutée"
      redirect_to :edit_counterparts
    end
  end

  def shares
    render :layout => 'application_edit_project'
  end

  def credits
    render :layout => 'application_edit_project'
  end

  def delete
    @project = Project.where(:title => params[:proj_name], :id => params[:id]).first
    if user_is_owner_of_the_project(@project) == false
      redirect_to root_path
      return 
    end

    if @project.delete
      flash[:notice] = "Projet effacé"
      redirect_to :action => 'index'
    else
      flash[:notice] = "Le projet n'a pas pu etre effacé"
      redirect_to :action => 'index'
    end
  end

  #
  # After edit in bac a sable
  #
  def submit
    @project = Project.find_by_id(params[:project][:id])
    print 'a'*99, @project
    if user_is_owner_of_the_project(@project) == false 
      redirect_to root_path
    end
    if @project.update_attributes(params[:project])
      flash[:notice] = 'Modifications enregistrées'
      redirect_to :action => 'show', :proj_name => @project.title, :id => @project.id
      return 
    else
      # error (TODO)
      render :action => "edit_project"
    end                               
  end

  def show 
    @project = Project.where(:title => params[:proj_name], :id => params[:id]).first
    if user_is_owner_of_the_project(@project) == false
      redirect_to root_path
      return 
    end
    # It impact on tab_content.html.erb
    @editable = true
    render :layout => 'show_project_layout'
    return 
  end








  #
  # Projet creation Step_1
  #
  def choice
    
  end

  def preview
    if params[:type] == 'entreprise'
      @url = new_enterprise_path
    else params[:type] == 'project'
      @url = new_project_path
    end
  end

  def new_enterprise
    @project = Project.new
  end

  def new_project
    @project = Project.new
  end

  def step_1

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end

  def create
    if params[:project][:id] == "shares"
      params[:project][:capital_stock_type] = 1
      params[:project][:personalized_reward] = 0
    elsif params[:project][:id] == "counterparts"
      params[:project][:personalized_reward] = 1
      params[:project][:capital_stock_type] = 0
    else
      render :status => 404
      return 
    end

    @project = Project.new(params[:project])
    @project_user = ProjectUser.new(:user => current_user, :project => @project)
    respond_to do |format|
      if @project.save
        if @project_user.save
          format.html { redirect_to edit_show_path(:proj_name => @project.title, :id => @project.id) }
          format.json { render json: @project, status: :created, location: @project }
        end

        if params[:project][:id] == "shares"
          format.html { render action: "new_enterprise" }
        else
          format.html { render action: "new_project" }
        end
        format.json { render json: @project.errors, status: :unprocessable_entity }
      else
        if params[:project][:id] == "shares"
          format.html { render action: "new_enterprise" }
        else
          format.html { render action: "new_project" }
        end
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end


end
