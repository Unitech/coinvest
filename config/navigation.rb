# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  # Specify a custom renderer if needed.
  # The default renderer is SimpleNavigation::Renderer::List which renders HTML lists.
  # The renderer can also be specified as option in the render_navigation call.
  # navigation.renderer = Your::Custom::Renderer

  # Specify the class that will be applied to active navigation items. Defaults to 'selected'
  # navigation.selected_class = 'your_selected_class'

  # Item keys are normally added to list items as id.
  # This setting turns that off
  # navigation.autogenerate_item_ids = false

  # You can override the default logic that is used to autogenerate the item ids.
  # To do this, define a Proc which takes the key of the current item as argument.
  # The example below would add a prefix to each key.
  # navigation.id_generator = Proc.new {|key| "my-prefix-#{key}"}

  # If you need to add custom html around item names, you can define a proc that will be called with the name you pass in to the navigation.
  # The example below shows how to wrap items spans.
  # navigation.name_generator = Proc.new {|name| "<span>#{name}</span>"}

  # The auto highlight feature is turned on by default.
  # This turns it off globally (for the whole plugin)
  # navigation.auto_highlight = false

  # Define the primary navigation
  navigation.items do |primary|
    # Add an item to the primary navigation. The following params apply:
    # key - a symbol which uniquely defines your navigation item in the scope of the primary_navigation
    # name - will be displayed in the rendered navigation. This can also be a call to your I18n-framework.
    # url - the address that the generated item links to. You can also use url_helpers (named routes, restful routes helper, url_for etc.)
    # options - can be used to specify attributes that will be included in the rendered navigation item (e.g. id, class etc.)
    #           some special options that can be set:
    #           :if - Specifies a proc to call to determine if the item should
    #                 be rendered (e.g. <tt>:if => Proc.new { current_user.admin? }</tt>). The
    #                 proc should evaluate to a true or false value and is evaluated in the context of the view.
    #           :unless - Specifies a proc to call to determine if the item should not
    #                     be rendered (e.g. <tt>:unless => Proc.new { current_user.admin? }</tt>). The
    #                     proc should evaluate to a true or false value and is evaluated in the context of the view.
    #           :method - Specifies the http-method for the generated link - default is :get.
    #           :highlights_on - if autohighlighting is turned off and/or you want to explicitly specify
    #                            when the item should be highlighted, you can set a regexp which is matched
    #                            against the current URI.
    #

    primary.dom_class = 'topnav'

    primary.item :key_1, 'Accueil', root_path

    primary.item :key_2, 'Projets en cours', list_projects_path do |f| 
      f.dom_class = 'subnav'
      f.item :discover_company, 'Les entreprises', list_projects_path(:type => 'entreprise') do |t|
        t.dom_class = 'subsubnav'
        t.item :recent, 'Bientôt terminé', list_projects_path(:sort => 'finishing', :type => 'entreprise')
        t.item :recent, 'Les plus récents', list_projects_path(:sort => 'recent', :type => 'entreprise')
      end

      f.item :discover_project, 'Les projets', list_projects_path(:type => 'projets') do |t| 
        t.dom_class = 'subsubnav'
        t.item :recent, 'Bientôt terminé', list_projects_path(:sort => 'finishing', :type => 'project')
        t.item :recent, 'Les plus récents', list_projects_path(:sort => 'recent', :type => 'project')
      end


   
      f.item :recent, 'Projets terminés', list_projects_path + '?sort=finished'
      # f.item :sort, 'Bientôt terminé', list_projects_path + '?sort=finishing'
      # f.item :sort, 'Les plus récents', list_projects_path + '?sort=recent'
    end

    # primary.item :key_2, 'Projets en attente', list_waiting_projects_path do |f| 
    #   f.dom_class = 'subnav'
    #   f.item :discover_company, 'Les entreprises', list_waiting_projects_path + '?type=entreprise'
    #   f.item :discover_project, 'Les projets', list_waiting_projects_path + '?type=projets'
    #   f.item :recent, 'Bientôt terminé', list_waiting_projects_path + '?type=finishing'
    #   f.item :recent, 'Les plus récents', list_waiting_projects_path + '?type=recent'
    # end

    # , :highlights_on => /bac_a_sable/
    primary.item :key_3, 'Créez !', new_choice_path do |f|
      #f.dom_class = 'subnav'
      #f.item :submit_company, 'Déposer votre entreprise', create_new_proj_path(:type => 'entreprise')
      #f.item :submit_project, 'Déposez votre projet', create_new_proj_path(:type => 'projet')
    end

    primary.item :key_4, 'En savoir plus', plus_comment_ca_marche_path do |f|
      f.dom_class = 'subnav'
      f.item :how_it_works, 'À propos', plus_comment_ca_marche_path
      f.item :about_us, 'Qui sommes-nous ?', plus_qui_sommes_nous_path
      f.item :faq, 'FAQ', plus_faq_path
      #f.item :contact_us, 'Contactez-nous', plus_contactez_nous_path
      #f.item :condition_generales, 'Conditions générales', plus_conditions_generales_path
    end
    
    primary.item :key_5, 'Forum', '#5'


    primary.item :key_6, 'Mon profil', profil_index_path, :if => Proc.new {!current_user.nil?}, :style => ' display : none' do |f|
      f.dom_class = 'pagination-profil'
      f.item :general_informations, 'Informations générales', profil_index_path

      f.item :project_listing, 'Projets', profil_projects_listing_path do |p|
        p.dom_class = 'sub-profil'
        p.item :project_launched, 'Mes projets', profil_projects_listing_path
        p.item :project_paid, 'Projets soutenus', profil_projects_paid_path
        p.item :project_followed, 'Projets suivis', profil_projects_followed_path
      end
      f.item :credits, 'Crédits', profil_credits_recapitulatif_path do |c|
        c.dom_class = 'sub-profil'
        c.item :recapitulatif, 'Récapitulatif', profil_credits_recapitulatif_path
        #c.item :historic, 'Historique', profil_credits_historic_path
        c.item :add_credit, 'Déposer crédits', profil_credits_checkin_path
        c.item :retrait, 'Retrait', profil_credits_checkout_path
      end

    end
    # primary.item :key_5, 'Mon profil', profil_path, :if => Proc.new {!current_user.nil?}, :style => ' display : inline-block; margin-left : 403px;'
    #primary.item :key_4, 'Mes projets', edit_list_path, :if => Proc.new {!current_user.nil?}

    # primary.item :key_4, 'Mes projets', edit_list_path, :if => Proc.new {!current_user.nil?}

    # primary.item :key_5, 'Editer', edit_one_project_path do |sub_nav|
    #   sub_nav.dom_class = 'submenu-edit'
    #   sub_nav.item :key_5_0, 'Show preview', edit_show_path
    #   #sub_nav.item :key_5_1, 'Retourner à la fiche projet', edit_show_project_path
    #   sub_nav.item :key_5_2, 'Informations principales', edit_one_project_path
    #   sub_nav.item :key_5_3, 'Contreparties', edit_counterparts_path
    #   sub_nav.item :key_5_5, 'Statistiques projet', edit_credits_path
    # end

    # You can also specify a condition-proc that needs to be fullfilled to display an item.
    # Conditions are part of the options. They are evaluated in the context of the views,
    # thus you can use all the methods and vars you have available in the views.
    # primary.item :key_3, 'Admin', url, :class => 'special', :if => Proc.new { current_user.admin? }
    # primary.item :key_4, 'Account', url, :unless => Proc.new { logged_in? }

    # you can also specify a css id or class to attach to this particular level
    # works for all levels of the menu
    # primary.dom_id = 'menu-id'
    # primary.dom_class = 'menu-class'

    # You can turn off auto highlighting for a specific level
    # primary.auto_highlight = false

  end

end
