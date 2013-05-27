require 'spec_helper'

describe UserAccount do
  let(:user) { FactoryGirl.create(:user)}
  let(:account) { FactoryGirl.create(:account)}
  before do
    @user_account = user.user_accounts.build(account_id: account.id, name:"My Wells Fargo Checking", authorized: false)
  end

  subject { @user_account }
  it { should respond_to(:user_id)}
  it { should respond_to(:account_id)}
  it { should respond_to(:name)}
  it { should respond_to(:authorized)}
  it { should respond_to(:user)}
  its(:user) { should == user }

  it { should be_valid }

  describe "when user_id is not present" do
    before{ @user_account.user_id = nil }
    it { should_not be_valid }
  end

  describe "when account_id is not present" do
    before { @user_account.account_id = nil }
    it { should_not be_valid }
  end

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        UserAccount.new( user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end
end