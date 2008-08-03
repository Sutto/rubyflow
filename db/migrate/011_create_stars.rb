class CreateStars < ActiveRecord::Migration
  def self.up
    create_table :stars, :id => false do |t|
      t.integer :item_id
      t.integer :user_id
    end
  end

  def self.down
    drop_table :stars
  end
end
