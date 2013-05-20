require 'spec_helper'

describe "Static pages" do
  subject { page }

  describe "Home page" do

    describe 'for signed in users' do
      let(:user) { FactoryGirl.create(:user)}
      before do
        FactoryGirl.create(:micropost, user: user, content: ' test 1 ')
        FactoryGirl.create(:micropost, user: user, content: ' test 2')
        sign_in user
        visit root_path
      end
      it "should render the user's feed " do
        user.feed.each do |item|
          page.should have_select("li##{item.id}", text: item.content)
        end
      end

      describe 'follower/following counts' do
        let(:other_user) { FactoryGirl.create(:user)}
        before do
          other_user.follow!(user)
          visit root_path
        end

        it { should have_link("0 following", href: following_user_path(user))}
        it { should have_link("1 followers", href: followers_user_path(user))}
      end
    end

    before { visit root_path }

    it "should have the content 'PARC360'" do
      should have_content('PARC360')
    end

    it "should have the title 'Home'" do
      should have_selector('title',
                                :text => "PARC360")
    end

    it "should have the base title" do
      should have_selector('title',
                                :text => "PARC360")
    end

    it "should not have a custom page title" do
      should_not have_selector('title', :text => '| Home')
    end
  end
  describe "Help page" do
    before { visit help_path }

    it "should have the content 'Help'" do
      should have_content('Help')
    end

    it "should have the title 'Help'" do
      should have_selector('title',
                                :text => "PARC360 | Help")
    end
  end
  describe "About page" do
    before { visit about_path }
    it {should have_content('About Us')}
    it {should have_selector('title',:text => "PARC360 | About")}
  end
  describe "Contact page" do
    before { visit contact_path }
    it {should have_selector('h1', text: 'Contact')}
    it { should have_selector('title',text: "PARC360 | Contact")}
  end


end
