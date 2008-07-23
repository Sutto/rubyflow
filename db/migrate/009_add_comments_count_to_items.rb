class AddCommentsCountToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :comments_count, :integer, :default => 0
  end

  def self.down
    remove_column :items, :comments_count
  end
end
