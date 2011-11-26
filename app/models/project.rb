# -*- coding: utf-8 -*-
class Project < ActiveRecord::Base
  before_create :default_values

  has_many :project_users
  has_many :users, :through => :project_users
  has_many :counterparts  
  has_many :comments

  # Paperclip
  has_attached_file :project_image, 
                    :styles => { :medium => "640x360#", :thumb => "320x180#" }, 
                    :default_url => "/system/project_images/640-360.png"


  validates_presence_of :title, 
                        :message => 'Le titre du projet doit être présent'
  validates_presence_of :short_descr, 
                        :message => 'La description courte doit être présente'
  validates_presence_of :wish_money, 
                        :message => 'Vous devez indiquer l\'argent voulu'
  validates_uniqueness_of :title, 
                          :message => 'Le titre du projet est déjà pris'
  validates_length_of :title, 
                      :maximum => 40, 
                      :message => 'Le titre doit être inférieur à 40 caractères'
  validates_format_of :title, 
                      :with => /^[a-zA-Z\d ]*$/i, 
                      :message => "Le titre ne peut pas contenir de caractères spéciaux"  

  validates_numericality_of :wish_money, 
                            :message => 'L\'argent voulu ne doit contenir que des chiffres'

  validates :date_end_wish, :presence => true

  def get_url
    return "/" + self.title
  end

  #
  # Todo
  #
  def pourcentage_realized
    58
  end

  def investor
    users = []
    self.counterparts.each do |c| 
      c.counterpart_users.each do |g|
        users << User.find(g.user_id)
      end
    end
    return users
  end

  protected
  def default_values
    self.validated ||= 0
    self.submited ||= 0
    self.description ||= 'Ma description'
  end
end
