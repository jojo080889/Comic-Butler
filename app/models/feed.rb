class Feed < ActiveRecord::Base
  attr_accessible :name, :url, :bookmarkDate

  has_many :feeditems
end
