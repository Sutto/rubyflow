class ChangeTagsToTextOnItems < ActiveRecord::Migration
  def self.up
    change_column :items, :tags, :text
  end

  def self.down
    change_column :items, :tags, :string
  end
end
