# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :account do
    name "Checking"
    vendor_name "Wells Fargo"
    url "http://www.wellsfargo.com"
  end
end
