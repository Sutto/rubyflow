class AddBylineToItem < ActiveRecord::Migration
  def self.up
    add_column :items, :byline, :string
  end

  def self.down
    remove_column :items, :byline
  end
end
