require 'spec_helper'

describe "User pages" do

  subject { page }

  # Listing 7.9
  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end # end Listing 7.9

# Listing 7.16
describe "signup" do

    before { visit signup_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
      # Listing 7.31
      describe "after submission" do
        before { click_button submit }

        it { should have_title('Sign up') }
        it { should have_content('error') }
      end # end Listing 7.31
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end
      
      # Listing 7.32
      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_link('Sign out') } # Listing 8.26
        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end # end Listing 7.32

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end # end Listing 7.16

# Listing 7.9
# describe "signup page" do
#   before { visit signup_path }
#
#   it { should have_content('Sign up') }
#   it { should have_title(full_title('Sign up')) }
# end # end Listing 7.9
end