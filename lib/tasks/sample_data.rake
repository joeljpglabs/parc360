namespace :db do
  desc 'Fill the database with sample data'
  task populate: :environment do
    make_users
    make_microposts
    make_relationships
    make_accounts
    make_user_accounts
  end
end

def make_users
  admin = User.create!(name:'Example User',
                        email: 'example@railstutorial.org',
                        password: 'foobar',
                        password_confirmation: 'foobar')
  admin.toggle!(:admin)

  99.times do |n|
    name = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password = "password"
    User.create!( name: name,
                email: email,
                password: password,
                password_confirmation: password)
  end
end

def make_microposts
  users = User.all(limit:6)
  50.times do
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.microposts.create!( content: content)}
  end
end

def make_relationships
  users = User.all
  user = users.first
  followed_users = users[2..50]
  followers = users[3..40]
  followed_users.each { |followed| user.follow!( followed )}
  followers.each { |follower| follower.follow!( user )}
end

def make_accounts
  Account.create!( name: 'Checking',
                  vendor_name: 'Wells Fargo',
                  url: 'http://www.wellsfargo.com')
  Account.create!( name: 'Savings',
                  vendor_name: 'Bank of America',
                  url: 'http://www.bofa.com')
end

def make_user_accounts
  users = User.all(limit:6)
  accounts = Account.all
  name = Faker::Lorem.sentence( 1 )
  users.each { |user| accounts.each { |account| user.user_accounts.create!( account_id: account.id, name: name)}}
end
