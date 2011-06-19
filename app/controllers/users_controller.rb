class UsersController < ApplicationController
  #require 'nokogiri'
  require 'open-uri'
  require 'rss'

  before_filter :authenticate, :only => [:show]
  before_filter :correct_user, :only => [:show]

  def new
  end

  def show
    @feed = Feed.find_by_id(44); #megatokyo
    @feeditems = @feed.feeditems.paginate(:page => params[:page])
  end

  private

  def authenticate
    deny_access unless signed_in?
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def retrieve_feed
    @feed = Feed.create!(:name => "Megatokyo", :url => "http://megatokyo.com/rss/megatokyo.xml", :bookmarkDate => "Wed, 1 Jun 2011 10:26:58 -0500")

    #clear previous feeds
    olditems = Feeditem.where("feed_id <> ?", @feed.id)
    olditems.map do |i|
      i.destroy
    end

    doc = Nokogiri::XML(open("http://megatokyo.com/rss/megatokyo.xml"))

    items = doc.xpath('//item').map do |i|
      {'title' => i.xpath('title').inner_text, 'link' => i.xpath('link').inner_text, 'description' => i.xpath('description').inner_text, 'pubDate' => i.xpath('pubDate').inner_text}
    end

    items.map do |i|
      @feed.feeditems.create!(:title => i['title'], :link => i['link'], :description => i['description'], :pubDate => i['pubDate'])
    end   
  end

end
