class UserAccount < ActiveRecord::Base
  attr_accessible :authorized,  :name, :account_id
  belongs_to :user
  belongs_to :account

  validates :user_id, presence: true
  validates :account_id, presence: true
  validates :name, presence: true, length: { maximum: 255}
end
