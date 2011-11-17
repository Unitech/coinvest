class RegisterController < ApplicationController
  before_filter :user_already_signed
  
  # Cf helper for ressource form Device
  def investor
  end

  def entrepreneur
  end

  protected

  # If user already logged in redirect to his profil
  def user_already_signed
    if user_signed_in? == true
      redirect_to(:controller => 'profil', :action => 'index')
    end
  end
end
