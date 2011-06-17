class RemovePasswordFromUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :password
    remove_column :users, :password_confirmation
  end

  def self.down
  end
end
