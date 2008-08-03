class RecreateStarsTable < ActiveRecord::Migration
  def self.up
		drop_table(:stars)
		create_table :stars do |t|
			t.integer	:user_id
			t.integer	:item_id		    
		end
  end

  def self.down
  end                   

end
