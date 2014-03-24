require 'spec_helper'

describe "Authentication" do
  # listing 8.1
  subject { page }

  describe "signin page" do
    before { visit signin_path }
       
      it { should have_content('Sign in') }
      it { should have_title('Sign in') }
  end   # end Listing 8.1
   
  # Listing 8.5
  describe "signin" do
    before { visit signin_path }
        
    describe "with invalid information" do
      before { click_button "Sign in" }
                   
      it { should have_title('Sign in') }
      # it { should have_error_message('Invalid') } # Listing 8.5
      it { should have_selector('div.alert.alert-error') }
      # Listing 8.11
      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-error') }
      end # end Listing 8.11
    end # end Listing 8.5

    # Listing 8.6
    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email",    with: user.email.upcase
        fill_in "Password", with: user.password
        click_button "Sign in"
      end

      it { should have_title(user.name) }
   #  it { should have_link('Users',       href: users_path) }
      it { should have_link('Profile',     href: user_path(user), visible: false) } 
   # above line from http://stackoverflow.com/questions/20594525/michael-hartls-rails-tutorial-exercise-8-1-rspec-failures
   #  it { should have_link('Settings',    href: edit_user_path(user)) }
      it { should have_link('Sign out',    href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }
      
      # Listing 8.28
      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link('Sign in') }
      end # end Listing 8.28
    end # End Listing 8.6
  end # end signin
end  # end "Authentication"