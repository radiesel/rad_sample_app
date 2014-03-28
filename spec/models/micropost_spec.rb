require 'spec_helper'
 
# Listing 10.2
describe Micropost do

  let(:user) { FactoryGirl.create(:user) }
  before { @micropost = user.microposts.build(content: "Lorem ipsum") } # Listing 10.5 

 # Listing 10.5 before do
 # Listing 10.5    # This code is not idiomatically correct.
 # Listing 10.5    @micropost = Micropost.new(content: "Lorem ipsum", user_id: user.id)
 # Listing 10.5  end

  subject { @micropost }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) } # Listing 10.5
  its(:user) { should eq user } # Listing 10.5
  # Listing 10.3
  
  it { should be_valid }

  describe "when user_id is not present" do
    before { @micropost.user_id = nil }
    it { should_not be_valid }
  end # end Listing 10.3

  # Listing 10.14
  describe "with blank content" do
    before { @micropost.content = " " }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { @micropost.content = "a" * 141 }
    it { should_not be_valid }
  end # end Listing 10.14
end # end Listing 10.2