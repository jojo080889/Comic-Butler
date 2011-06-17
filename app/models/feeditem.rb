class Feeditem < ActiveRecord::Base
  attr_accessible :title, :link, :description, :pubDate

  belongs_to :feed, :dependent => :destroy
  
  validates :title, :presence => true
  validates :link, :presence => true
  validates :feed_id, :presence => true
  validates :pubDate, :presence => true

  default_scope :order => 'feeditems.pubDate DESC'
end
