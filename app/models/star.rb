class Star < ActiveRecord::Base
	
	belongs_to :user
	belongs_to :item, :counter_cache => true
	
	# Prevent people starring something multiple times.
	validates_uniqueness_of :item_id, :scope => :user_id, :on => :create, :message => "must be unique"
	
end
