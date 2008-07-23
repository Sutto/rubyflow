class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :name
      t.string :title
      t.references :parent
      t.string :query

      t.timestamps
    end
  end

  def self.down
    drop_table :categories
  end
end
