class SessionsController < ApplicationController
  # Listing 8.3
  def new
  end

  def create # Listing 8.10
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Listing 8.13
      sign_in user
      redirect_to user
      # end Listing 8.13
    else
   # Listing 8.12   flash[:error] = 'Invalid email/password combination' # Listing 8.10
      flash.now[:error] = 'Invalid email/password combination' # Listing 8.12
      render 'new'  # Listing 8.9
    end
  end # end Listing 8.10

  def destroy
  end
  # end Listing 8.3
end # end SessionsController