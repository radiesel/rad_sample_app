class RelationshipsController < ApplicationController
# Listing 11.34
  before_action :signed_in_user

  respond_to :html, :js # Listing 11.47 
  
  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    respond_with @user # Listing 11.47 
    # Listing 11.38 redirect_to @user
    # Listing 11.38 
    # Listing 11.47 respond_to do |format|
    # Listing 11.47  format.html { redirect_to @user }
    # Listing 11.47  format.js
    # Listing 11.47 end # end Listing 11.38 
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    respond_with @user # Listing 11.47
    # Listing 11.38 redirect_to @user
    # Listing 11.38
    # Listing 11.47 respond_to do |format|
    # Listing 11.47   format.html { redirect_to @user }
    # Listing 11.47   format.js
    # Listing 11.47 end # end Listing 11.38 
  end
end # end Listing 11.34