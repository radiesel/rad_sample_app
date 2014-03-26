# Listing 7.8
FactoryGirl.define do
  factory :user do
  # Listing 9.31
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"
    # Listing 9.41
    factory :admin do
      admin true
    end
    # end Listing 9.41
# end Listing 9.31
# Listing 9.31   name     "Michael Hartl"
# Listing 9.31    email    "michael@example.com"
# Listing 9.31    password "foobar"
# Listing 9.31    password_confirmation "foobar"
  end # end Listing 7.8
end