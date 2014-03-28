class User < ActiveRecord::Base
  # Listing 10.13 has_many :microposts # Listing 10.8
  has_many :microposts, dependent: :destroy # Listing 10.13
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
    Micropost.where("user_id = ?", id)
  end # end Listing 10.36
  private

    def create_remember_token
      self.remember_token = User.hash(User.new_remember_token)
    end
  # end Listing 8.18
end
