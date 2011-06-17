class CreateFeeditems < ActiveRecord::Migration
  def self.up
    create_table :feeditems do |t|
      t.integer :feed_id
      t.string :title
      t.string :link
      t.string :description
      t.datetime :pubDate

      t.timestamps
    end
    add_index :feeditems, :feed_id
    add_index :feeditems, :pubDate
  end

  def self.down
    drop_table :feeditems
  end
end
