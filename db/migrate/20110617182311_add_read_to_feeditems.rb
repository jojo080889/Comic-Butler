class AddReadToFeeditems < ActiveRecord::Migration
  def self.up
    add_column :feeditems, :read, :boolean, :default => true
  end

  def self.down
    remove_column :feeditems, :read
  end
end
