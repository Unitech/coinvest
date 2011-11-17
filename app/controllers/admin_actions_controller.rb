class AdminActionsController < ApplicationController
  def index
  end

  def projets_en_attente
    ord = 'created_at DESC'
    cond = ['submited = ? and validated = ? ', true, false]

    case params[:type]
    when 'entreprise'
      cond = ['submited = ? and capital_stock_type = ?', true, true]
    when 'projets'
      cond = ['submited = ? and personalized_reward = ? ', true, true]
    when 'finishing'
      ord = 'date_end_wish ASC'
    when 'recent'
      ord = 'date_end_wish DESC'
    end

    @projects = Project.paginate :page => params[:page], :per_page => 6, :order => ord, :conditions => cond
  end

  def profils_utilisateur
    @users = User.all
  end
  
  def profil_specifique
    @user = User.find_by_id(params[:user_id])
    @historic = @user.credit_historics
  end

  def confirm_project
    #
    # Verif si c'est un admin
    #
    @project = Project.where(:id => params[:id]).first
    @project.update_attributes(:validated => true)
    render :json => {:success => true}
  end



end
