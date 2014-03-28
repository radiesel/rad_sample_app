class Micropost < ActiveRecord::Base
	belongs_to :user # Listing 10.7 
	default_scope -> { order('created_at DESC') } # Listing 10.11
	validates :content, presence: true, length: { maximum: 140 } # Listing 10.15
	validates :user_id, presence: true # Listing 10.4
end
