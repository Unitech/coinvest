# -*- coding: utf-8 -*-
class User < ActiveRecord::Base
  #
  # Before saving to DB set default values (credits)
  #
  before_create :default_values

  #
  # Relation
  #
  has_many :project_user
  has_many :projects, :through => :project_user
  has_many :counterpart_users  
  has_many :credit_historics
  has_many :comments

  #
  # Devise configuration
  #
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  
  #
  # Set accessible fields 
  #
  attr_accessible :email, :password, :password_confirmation, :remember_me, :user_type,
                  :f_name, :l_name, :birth_date, :birth_place, :nationality,
                  :address, :postal_code, :city, :phone_number, :web_site,
                  :photo_path, :receive_newsletter, :projects, :sex, :country, :credits
  
  #
  # Set virtual field
  #
  attr_accessor :login
  
  #
  # Validations
  #
  validates_presence_of :f_name, :message => 'Prenom obligatoire'
  validates_presence_of :l_name, :message => 'Nom obligatoire'
  validates_uniqueness_of :email, :message => 'L\'adresse mail est déjà prise'


  #
  # Some helpers
  #
  def remove_credits(credits)
    @credits = self.credits - credits
    if @credits < 0
      return false
    end
    self.update_attributes(:credits => @credits)
    return true
  end

  def add_credits(credits)
    @credits = self.credits + credits
    self.update_attributes(:credits => @credits)
  end
  

  #
  # Facebook AUTH
  #
  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token['extra']['user_hash']

    if user = User.find_by_email(data["email"])
      user
    else # Create a user with a stub password.   
      User.create!(:f_name => data["first_name"], :l_name => data["last_name"], :sex => data["gender"], :city => data["location"]["name"], :email => data["email"], :password => Devise.friendly_token[0,20])
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["user_hash"]
        user.email = data["email"]
      end
    end
  end
 
  #
  # Private methods
  #
  protected
  def default_values
    self.credits = 0
  end
end
