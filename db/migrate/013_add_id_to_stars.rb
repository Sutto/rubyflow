class AddIdToStars < ActiveRecord::Migration
  def self.up
		add_column :stars, :id, :integer, :primary_key => true
  end

  def self.down                         
		remove_column :stars, :id
  end
end
