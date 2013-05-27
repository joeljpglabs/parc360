require 'spec_helper'

describe Account do
  before do
    @account = Account.new( name: "My Checking",  vendor_name:"Wells Fargo", url: "http://www.wellsfargo.com/")
  end

  subject { @account }
  it { should respond_to(:name)}
  it { should respond_to(:vendor_name)}
  it { should respond_to(:url)}
end
