class MicropostsController < ApplicationController
# Listing 10.25  
  before_action :signed_in_user, only: [:create, :destroy]
  # Listing 10.25 before_action :signed_in_user
  before_action :correct_user,   only: :destroy # Listing 10.46

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = [] # Listing 10.42
      render 'static_pages/home'
    end
  end

  def destroy
  end

 # Listing 10.46
 def destroy
    @micropost.destroy
    redirect_to root_url
  end # end Listing 10.46

  private

    def micropost_params
      params.require(:micropost).permit(:content)
    end

    # Listing 10.46
     def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end # end Listing 10.46
end # end Listing 10.25 