class AddBookmarkDateToFeeds < ActiveRecord::Migration
  def self.up
    add_column :feeds, :bookmarkDate, :datetime
  end

  def self.down
    remove_column :feeds, :bookmarkDate
  end
end
