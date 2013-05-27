# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_account do
    user_id 1
    account_id 1
    name "Joel's Checking with Wells Fargo"
    authorized false
  end
end
