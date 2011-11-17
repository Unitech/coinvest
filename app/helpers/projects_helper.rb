module ProjectsHelper
  def user_is_owner?
    if user_signed_in? == true and @project.users[0].id == current_user.id
      return true
    end
    return false
  end
  
end
