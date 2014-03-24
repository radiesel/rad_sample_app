module SessionsHelper
  # Listing 8.19
  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.hash(remember_token))
    self.current_user = user
  end # end Listing 8.19
  
  # Listing 8.23
  def signed_in?
    !current_user.nil?
  end
  # end Listing 8.23
  
  # Listing 8.20
  def current_user=(user)
    @current_user = user
  end # end  Listing 8.20
  # Listing 8.22
  def current_user
    remember_token = User.hash(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end # end Listing 8.22
end