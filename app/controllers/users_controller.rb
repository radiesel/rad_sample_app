class UsersController < ApplicationController
  def new
  end
  # Listing 7.26
  def create
    @user = User.new(user_params)
    if @user.save
      # Listing 7.28
      flash[:success] = "Welcome to the Sample App!"
      # end Listing 7.28
      redirect_to @user
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end # end Listing 7.26
end
