# Listing 9.29
namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
     # Listing 11.17
     make_users
     make_microposts
     make_relationships
  end # end Listing 11.17
end # end Listing 11.17 Listing 9.29

  # Listing 9.40
  # Listing 11.17  
  def make_users  
  	admin = User.create!(name: "Example User",
                        email: "example@railstutorial.org",
                        password: "RubyRails@0",
                        password_confirmation: "RubyRails@0",
                        admin: true)
    # end Listing 9.40
    98.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
        admin = User.create!(name: "Ric Diesel",
                        email: "ric.diesel@gmail.com",
                        password: "RubyRails@0",
                        password_confirmation: "RubyRails@0",
                        admin: true)
  end # end Listing 11.17  

    # Listing 9.40 User.create!(name: "Example User",
    # Listing 9.40             email: "example@railstutorial.org",
    # Listing 9.40             password: "foobar",
    # Listing 9.40             password_confirmation: "foobar")
    
  # Listing 10.20
  # Listing 11 .17 
  def make_microposts
    users = User.all(limit: 6)
    50.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.microposts.create!(content: content) }
    end # Listing 10.20
  end # end Listing 11 .17

  # Listing 11.17
  def make_relationships
    users = User.all
    user  = users.first
    followed_users = users[2..50]
    followers      = users[3..40]
    followed_users.each { |followed| user.follow!(followed) }
    followers.each      { |follower| follower.follow!(user) }
  end # end Listing 11.17 