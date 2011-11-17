# -*- coding: utf-8 -*-
#
#
class ProfilController < ApplicationController
  before_filter :authenticate_user!, :except => ['show_profil']
  layout 'profil_layout'

  def show_profil
  end

  def general_informations
    @user = current_user
  end
  
  def general_informations_submit
    if params[:user][:password] == ''
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    @user = User.find_by_id(current_user.id)
    if @user.update_attributes(params[:user])
      flash[:notice] = 'Modifications enregistrées'
      redirect_to :action => :general_informations
    else
      flash[:notice] = 'Erreur'
      render :action => :general_informations
    end                               
    
  end

  #
  # Projects
  #
  def projects_listing
    @project = current_user.projects
  end

  def projects_paid
  end

  def projects_followed
  end
  
  #
  # Credits
  #
  def credits
    @historic = current_user.credit_historics
  end

  def credits_historic
    # Unused
  end
  
  def credit_checkout
  end

  def credit_checkin
  end
  
  def add_credits
    user = User.find_by_id(current_user.id)
    # Check si ok de la part de la banque

    # add credits
    user.add_credits(params[:add_credits].to_i)
    # @credits = user.credits + params[:add_credits].to_i
    # user.update_attributes(:credits => @credits)

    # create historic
    CreditHistoric.create(:historic_type => 'crediter', :value => params[:add_credits].to_i, :user_id => user.id)
    
    redirect_to :action => 'credits'
  end

  def error
  end
end
