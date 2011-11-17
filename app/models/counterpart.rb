# -*- coding: utf-8 -*-
class Counterpart < ActiveRecord::Base
  belongs_to :project

  validates :bearing, :presence => true
  
  validates :description, :presence => true
  validates_numericality_of :bearing, :message => 'Le palier ne doit contenir que des chiffres'
  
  has_many :counterpart_users
  # Relier a des credits d'historique
  has_many :credit_historics
  # RAILS ADMIN
  # has_many :users, :through => :counterpart_users
end
