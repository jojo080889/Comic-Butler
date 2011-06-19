module FeedsHelper

  def unread_count(feed)
    feed.feeditems.count(:conditions => {:read => false})
  end

end
