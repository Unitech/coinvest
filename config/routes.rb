Coinvest::Application.routes.draw do

  #
  # Ressources
  #
  resources :bugs
  resources :comments

  #
  # Admin
  #
  scope :controller => :admin_actions, :path => '/backoffice', :as => :admin_actions do 
    get "projets_en_attente" => :projets_en_attente, :as => :projets_en_attente
    get "profils_utilisateur" => :profils_utilisateur, :as => :profils_utilisateur
    get "profil/:user_id" => :profil_specifique, :as => :profil_spe
    post "confirm" => :confirm_project, :as => :confirm
    get "/" => :index, :as => :index
  end
  #
  # Rails admin
  #
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  #
  # Fb omniauth
  #
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  devise_scope :user do
    get '/users/auth/:provider' => 'users/omniauth_callbacks#passthru'
  end

  match '/auth/:provider/callback', :to => 'sessions#create'

  #
  # Help pages
  #
  scope :controller => :misc, :path => 'more', :as => :plus do
    get "/about" => :comment_ca_marche, :as => :comment_ca_marche
    get "/faq" => :faq, :as => :faq
    get "/qui_sommes_nous" => :qui_sommes_nous, :as => :qui_sommes_nous
    get "/contactez_nous" => :contactez_nous, :as => :contactez_nous
    get "/conditions_generales" => :conditions_generales, :as => :conditions_generales
  end


  # Step 1 creation
  scope :controller => :bac_a_sable, :path => '/new' do
    match "/choice" => :choice, :as => :new_choice
    # first page - descriptif du depot de projet sur coinvest
    match "/preview/:type" => :preview, :as => :create_new_proj 

    match "/enterprise" => :new_enterprise, :as => :new_enterprise
    match "/project" => :new_project, :as => :new_project

    match "/step_1" => :step_1, :as => :step_1_proj
    match "/create" => :create
  end

  # Edit project
  scope :controller => :bac_a_sable, :path => '/bac_a_sable', :as => :edit do
    # Choice between creating an entreprise or a project
    # List project of the current user (to delete)
    match "/list_projects", :action => 'index', :as => :list

    # After edit in bac a sable
    match "/submit", :action => 'submit', :as => :submit
    match "/delete/:proj_name", :action => 'delete', :as => :delete
    match "/submit_counterpart/:id/:proj_name", :action => 'submit_counterpart', :as => :submit_counterpart
    match "/counterparts/:id/:proj_name", :action => 'edit_counterparts', :as => :counterparts
    match "/shares/:id/:proj_name", :action => 'shares', :as => :shares
    match "/credits/:id/:proj_name", :action => 'credits', :as => :credits
    match "/edit/:id/:proj_name", :action => 'edit_project', :as => :one_project
    match "/edit/business_plan/:id/:proj_name", :action => 'edit_business_plan', :as => :business_plan
    # Show le preview avec les bouttons edit
    post "/edit/submit_project_to_admin", :action => 'submit_project_to_admin', :as => :submit_to_admin
    # confirme le projet pour parution dans la list des projets en production
    match "/project/:id/:proj_name", :action => 'show', :as => :show
  end


  get "register/investor", :as => 'investor_register'
  get "register/entrepreneur", :as => 'entrepreneur_register'

  scope :controller => :profil, :path => '/profil', :as => :profil do
    match "/", :action => 'general_informations', :as => :index
    match "/general_informations_submit", :action => 'general_informations_submit', :as => :index_submit
    #
    scope :path => '/projects', :as => :projects do
      get "/projects_listing", :action => 'projects_listing', :as => :listing
      get "/projects_paid", :action => 'projects_paid', :as => :paid
      get "/projects_followed", :action => 'projects_followed', :as => :followed
    end
    #
    scope :path => '/credits', :as => :credits do
      get "/recapitulatif", :action => 'credits', :as => :recapitulatif
      get "/historic", :action => 'credits_historic', :as => :historic
      get "/checkin", :action => 'credits_checkin', :as => :checkin
      get "/checkout", :action => 'credits_checkout', :as => :checkout
      post "/add_credits", :action => 'add_credits', :as => :add
    end
  end


  scope :controller => :projects do 
    match "/buy_counterpart/:id", :action => :buy_counterpart, :as => :buy_counterpart
    match "/buy_counterpart", :action => :buy_counterpart, :as => :buy_counterpart
    match "/confirm_counterpart/:id", :action => :confirm_counterpart, :as => :confirm_counterpart
    match "/projects/:type", :action => :index, :as => :list_projects
    match "/projects/:type/:sort", :action => :index, :as => :list_projects
    match "/projects/:sort", :action => :index, :as => :list_projects
    match "/projects", :action => :index, :as => :list_projects
    match "/:proj_name", :action => :show, :as => :show_project
  end

  
  root :to => 'home#index'
end
