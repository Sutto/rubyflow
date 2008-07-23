class AddAdminFlagToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :admin, :integer, :default => 0
  end

  def self.down
    remove_column :users, :admin
  end
end
