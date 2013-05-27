class Account < ActiveRecord::Base
  attr_accessible :name, :url, :vendor_name

  validates :name, presence: true
  validates :url, presence: true
  validates :vendor_name, presence: true

end
