class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: "User" # Listing 11.6
  belongs_to :followed, class_name: "User" # Listing 11.6
  validates :follower_id, presence: true # Listing 11.8
  validates :followed_id, presence: true # Listing 11.8
end
