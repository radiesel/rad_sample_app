class User < ActiveRecord::Base
  # Listing 10.13 has_many :microposts # Listing 10.8
  has_many :microposts, dependent: :destroy # Listing 10.13
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy # Listing 11.4
  has_many :followed_users, through: :relationships, source: :followed # Listing 11.10
  has_many :reverse_relationships, foreign_key: "followed_id", class_name:  "Relationship", dependent: :destroy # Listing 11.16
  has_many :followers, through: :reverse_relationships, source: :follower # Listing 11.16 
  # Listing 6.31
  has_secure_password
  # Listing 8.18 before_save { email.downcase! } 
  # end Listing 6.31
  before_save { self.email = email.downcase } # Listing 8.18
  before_create :create_remember_token # Listing 8.18
  
  validates :name, presence: true, length: { maximum: 50 }
  # Listing 6.32
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  # end Listing 6.32
  validates :password, length: { minimum: 6 }

  # Listing 8.18
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.hash(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  
  # Listing 10.36
  def feed
    # This is preliminary. See "Following users" for the full implementation.
    # Listing 11.42 1Micropost.where("user_id = ?", id)
    Micropost.from_users_followed_by(self) # Listing 11.42 
  end # end Listing 10.36

  # Listing 11.12
  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end # end Listing 11.12

  # Listing 11.14
  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end # end Listing 11.14

  private

    def create_remember_token
      self.remember_token = User.hash(User.new_remember_token)
    end
  # end Listing 8.18
end
