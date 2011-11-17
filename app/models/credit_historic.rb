class CreditHistoric < ActiveRecord::Base
  HISTORIC_TYPE = %w( crediter depense retrait restituer )
  
  has_one :user
  has_one :counterpart
  
  
  validates_numericality_of :value
  validates_inclusion_of :historic_type, :in => HISTORIC_TYPE
  
end
