class StaticPagesController < ApplicationController

  # Listing 10.31
  def home
    # Listing 10.38
    if signed_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end # Listing 10.38   
  end # end Listing 10.31

  def help
  end
  
  def about
  end

  def contact
  end
 
end
