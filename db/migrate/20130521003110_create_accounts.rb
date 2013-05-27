class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :vendor_name
      t.string :url

      t.timestamps
    end
  end
end
