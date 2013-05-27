require 'spec_helper'

describe "UserAccount Pages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user)}
  before{ sign_in user}

  describe "user account creation" do
    before { visit accounts_user_path( user ) }

    describe "with valid information" do
      it "should create a user_account" do
        expect { click_button "Add Account"}.to change(UserAccount, :count).by(1)
      end
    end
  end

  describe "user_account destruction" do
    before { FactoryGirl.create(:user_account, user: user, account_id: 1)}

    describe "as correct user" do
      before { visit accounts_user_path( user ) }

      it "should delete a user_account" do
        expect { click_link "delete" }.to change(UserAccount, :count).by(-1)
      end
    end
  end
end
