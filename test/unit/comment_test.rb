require File.dirname(__FILE__) + '/../test_helper'

class CommentTest < ActiveSupport::TestCase
  should_belong_to :user
  should_belong_to :item
  
  should_ensure_length_in_range :content, (1..10000)
end
