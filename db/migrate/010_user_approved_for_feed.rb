class UserApprovedForFeed < ActiveRecord::Migration
  def self.up
    add_column :users, :approved_for_feed, :integer, :default => 0
  end

  def self.down
    remove_column :users, :approved_for_feed
  end
end
