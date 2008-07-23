class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :title
      t.string :url
      t.text :content
      t.text :metadata
      t.string :name
      t.string :tags
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
