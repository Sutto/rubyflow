class AddCounterCacheForStars < ActiveRecord::Migration
  def self.up
		add_column :items, :stars_count, :integer, :default => 0
  end

  def self.down                                             
		remove_column :stars_count
  end
end
