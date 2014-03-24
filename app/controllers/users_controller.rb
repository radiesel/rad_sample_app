class UsersController < ApplicationController
  # listing 7.5
  def show 
    @user = User.find(params[:id])
  end # end listing 7.5

  def new
    @user = User.new # Listing 7.18
  end
  
  # Listing 7.26
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user # Listing 8.27
      # Listing 7.28
      flash[:success] = "Welcome to the Sample App!"
      # end Listing 7.28
      redirect_to @user
    else
      render 'new'
    end
  end
  # Listing 7.21
# def create
#   @user = User.new(params[:user])    # Not the final implementation!
#   if @user.save
#     # Handle a successful save.
#    else
#      render 'new'
#    end
#  end # end Listing 7.21

  # Listing 7.22
  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end # end Listing 7.22
end
