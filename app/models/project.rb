# -*- coding: utf-8 -*-
class Project < ActiveRecord::Base
  before_create :default_values

  has_many :project_users
  has_many :users, :through => :project_users

  has_attached_file :project_image, :styles => { :medium => "640x360>", :thumb => "320x180>" }, :default_url => "/system/project_images/640-360.png"

  has_many :counterparts
  validates_presence_of :title, :message => 'Le titre du projet doit être présent'
  validates_presence_of :short_descr, :message => 'La description courte doit être présente'
  validates_uniqueness_of :title, :message => 'Le titre du projet est déjà pris'
  validates_length_of :title, :maximum => 40, :message => 'Le titre doit être inférieur à 40 caractères'
  validates_format_of :title, :with => /^[a-zA-Z\d ]*$/i, :message => "Le titre ne peut pas contenir de caractères spéciaux"
  
  validates_presence_of :wish_money, :message => 'Vous devez indiquer l\'argent voulu'
  validates_numericality_of :wish_money, :message => 'L\'argent voulu ne doit contenir que des chiffres'

  validates :date_end_wish, :presence => true

  def get_url
    return "/" + self.title
  end

  def pourcentage_realise
    58
  end

  # def get_edit_url
  #   return edit_one_project(self.title)
  # end

  def get_investor
    @investor = []
    if self.personalized_reward == true
      self.counterparts.each do |f| 
        f.counterpart_users.each do |c|
          
        end
      end
    else
    end
    return @investor
  end

  protected
  def default_values
    self.validated ||= 0
    self.submited ||= 0
    self.description ||= 'Ma description'
  end
end
