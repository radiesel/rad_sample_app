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
      
      before { sign_in user }
# Listing 9.6     before do
# Listing 9.6             fill_in "Email",    with: user.email.upcase
# Listing 9.6             fill_in "Password", with: user.password
# Listing 9.6             click_button "Sign in"
# Listing 9.6     end

      it { should have_title(user.name) }
    # it { should have_selector('title', text: user.name) }
      it { should have_link('Users',       href: users_path) }
      it { should have_link('Profile',     href: user_path(user), visible: false) } 
# Listing 9.26  it { should have_link('Profile',     href: user_path(user)) }
      it { should have_link('Settings',    href: edit_user_path(user)) } # Listing 9.5
      it { should have_link('Sign out',    href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }     

   # it { should have_link('Profile',     href: user_path(user), visible: false) }   
   # above line from http://stackoverflow.com/questions/20594525/michael-hartls-rails-tutorial-exercise-8-1-rspec-failures
      
      # Listing 8.28
      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link('Sign in') }
      end # end Listing 8.28
    end # End Listing 8.6
  end # end signin
  
  # Listing 9.11
 describe "authorization" do

    # Listing 9.45
    describe "as non-admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }

      before { sign_in non_admin, no_capybara: true }

      describe "submitting a DELETE request to the Users#destroy action" do
        before { delete user_path(user) }
        specify { expect(response).to redirect_to(root_url) }
      end
    end # end Listing 9.45
    
    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      # Listing 9.16
      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Email",    with: user.email
          fill_in "Password", with: user.password
          click_button "Sign in"
        end

        describe "after signing in" do

          it "should render the desired protected page" do
            expect(page).to have_title('Edit user')
          end

          # Listing 9.51
          describe "when signing in again" do
            before do
              click_link "Sign out"
              visit signin_path
              fill_in "Email",    with: user.email
              fill_in "Password", with: user.password
              click_button "Sign in"
            end 

            it "should render the default (profile) page" do
              expect(page).to have_title(user.name)
            end 
          end # end Listing 9.51
        end # "after signing in"               
      end # end Listing 9.16

      describe "in the Users controller" do

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_title('Sign in') }
        end
        # Listing 9.20
        describe "visiting the user index" do
          before { visit users_path }
          it { should have_title('Sign in') } 
        # it { should have_title('All users') } # Listing 9.33
        end # Listing 9.20

        describe "submitting to the update action" do
          before { patch user_path(user) }
          specify { expect(response).to redirect_to(signin_path) }
        end
      end # end "in the Users controller"

      # Listing 10.23
      describe "in the Microposts controller" do

        describe "submitting to the create action" do
          before { post microposts_path }
          specify { expect(response).to redirect_to(signin_path) }
        end

        describe "submitting to the destroy action" do
          before { delete micropost_path(FactoryGirl.create(:micropost)) }
          specify { expect(response).to redirect_to(signin_path) }
        end
      end # end Listing 10.23
      
    end # "for non-signed-in users" end Listing 9.11
    # Listing 9.13
    
    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { sign_in user, no_capybara: true }

      describe "submitting a GET request to the Users#edit action" do
        before { get edit_user_path(wrong_user) }
        specify { expect(response.body).not_to match(full_title('Edit user')) }
        specify { expect(response).to redirect_to(root_url) }
      end

      describe "submitting a PATCH request to the Users#update action" do
        before { patch user_path(wrong_user) }
        specify { expect(response).to redirect_to(root_url) }
      end
    end # end Listing 9.13
  end # end authorization 
end  # end "Authentication"