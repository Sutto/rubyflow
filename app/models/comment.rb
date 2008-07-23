class Comment < ActiveRecord::Base
  belongs_to :item, :counter_cache => true
  belongs_to :user
  
  validates_length_of :content, :within => 1..10000
end
