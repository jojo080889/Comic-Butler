class FeedsController < ApplicationController

  require 'nokogiri'
  require 'open-uri'


# DOESN'T WORK
  def create
    @feed = Feed.find_by_id(params[:id]) #megatokyo
    doc = Nokogiri::XML(open("http://megatokyo.com/rss/megatokyo.xml"))
    
    items = doc.xpath('//item').map do |i|
      {'title' => i.xpath('title').inner_text, 'link' => i.xpath('link').inner_text, 'description' => i.xpath('description').inner_text, 'pubDate' => i.xpath('pubDate').inner_text}
    end

    items.map do |i|
      @feed.feeditems.create!(:title => i['title'], :link => i['link'], :description => i['description'], :pubDate => i['pubDate'])
    end

    @feeditems = @feed.feeditems.paginate(:page => params[:page])
  end
end
