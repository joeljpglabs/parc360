class ChangeAuthorizedInUserAccounts < ActiveRecord::Migration
  def up
    change_column :user_accounts, :authorized, :boolean, default: false
  end

  def down
    change_column :user_accounts, :authorized, :boolean
  end
end
