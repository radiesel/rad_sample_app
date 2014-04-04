class Micropost < ActiveRecord::Base
	belongs_to :user # Listing 10.7 
	default_scope -> { order('created_at DESC') } # Listing 10.11
	validates :content, presence: true, length: { maximum: 140 } # Listing 10.15
	validates :user_id, presence: true # Listing 10.4
  # Listing 11.43 
  # Returns microposts from the users being followed by the given user.
  def self.from_users_followed_by(user)
    # Listing 11.45
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
          user_id: user.id) # end  Listing 11.45
  # Listing 11.45 followed_user_ids = user.followed_user_ids
  # Listing 11.45 where("user_id IN (?) OR user_id = ?", followed_user_ids, user)
  end # end Listing 11.43
end 
