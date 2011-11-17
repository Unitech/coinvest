class ApplicationController < ActionController::Base
  protect_from_forgery

  def user_is_owner_of_the_project(project)
    if @project != nil and @project.users[0].id == current_user.id
      return true
    end
    return false
  end

  def set_charset
    @headers["Content-Type"] = "text/html; charset=utf-8"
  end
end
