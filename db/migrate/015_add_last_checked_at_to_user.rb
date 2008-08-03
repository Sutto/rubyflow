class AddLastCheckedAtToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :last_checked_at, :datetime
  end

  def self.down
    remove_column :users, :last_checked_at
  end
end
