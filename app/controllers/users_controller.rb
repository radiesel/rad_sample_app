class UsersController < ApplicationController
  # Listing 9.12
  # Listing 9.34 before_action :signed_in_user, only: [:edit, :update]
  # Listing 9.44 before_action :signed_in_user, only: [:index, :edit, :update]
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy] # Listing 9.44 
  before_action :correct_user,   only: [:edit, :update] # Listing 9.14
  before_action :admin_user,     only: :destroy # Listing 9.46
 
 # listing 9.21
  def index 
    # Listing 9.23
    # Listing 0.34 @users = User.all
    @users = User.paginate(page: params[:page])
    # end Listing 9.23
  end # end listing 9.21

  # listing 7.5
  def show 
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page]) # Listing 10.19
  end # end listing 7.5

  # listing 9.44
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end # end listing 9.44

  # Listing 9.2
  def edit
    # Listing 9.14 @user = User.find(params[:id])
  end
  # end Listing 9.2
 
  # Listing 9.8
  def update
    # Listing 9.14 @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # Listing 9.10
      flash[:success] = "Profile updated"
      redirect_to @user
      # end Listing 9.10
    else
      render 'edit'
    end
  end   # end Listing 9.8
  
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

    # Listing 9.12
# Listing 10.24    def signed_in_user
# Listing 10.24    # Listing 9.18  redirect_to signin_url, notice: "Please sign in." unless signed_in?
# Listing 10.24      unless signed_in?
# Listing 10.24        store_location
# Listing 10.24        redirect_to signin_url, notice: "Please sign in."
# Listing 10.24      end # Listing 9.18 
# Listing 10.24    end # end Listing 9.12
    
    # Listing 9.14
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end # end Listing 9.14
    # Listing 9.46
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end # end Listing 9.46
end