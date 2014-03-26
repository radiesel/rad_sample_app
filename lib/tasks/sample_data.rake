# Listing 9.29
namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
  	# Listing 9.40
  	admin = User.create!(name: "Example User",
                        email: "example@railstutorial.org",
                        password: "RubyRails@0",
                        password_confirmation: "RubyRails@0",
                        admin: true)
    admin = User.create!(name: "Ric Diesel",
                        email: "ric.diesel@gmail.com",
                        password: "RubyRails@0",
                        password_confirmation: "RubyRails@0",
                        admin: true)
    # end Listing 9.40
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
      # Listing 9.40 User.create!(name: "Example User",
    # Listing 9.40             email: "example@railstutorial.org",
    # Listing 9.40             password: "foobar",
    # Listing 9.40             password_confirmation: "foobar")
  end
end

# end Listing 9.29