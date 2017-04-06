module SessionsHelper
  #defines create_session
  def create_session(user)
    session[:user_id] = user.id
  end

  #defines destroy_session. Clears the user id on the session object by setting it to nil
  def destroy_session(user)
    session[:user_id] = nil
  end

  #defines current_user, returning the current user of the application.
  def current_user
    User.find_by(id: session[:user_id])
  end
  
end
