require File.dirname(__FILE__) + '/../test_helper'

class ItemTest < ActiveSupport::TestCase
  fixtures :users
  
  # Replace this with your real tests.
  def test_cant_add_empty_item
    assert !Item.new.save
  end
  
  def test_can_add_item_with_no_name
    item = Item.new(:title => "Title", :user => users(:quentin))
    assert item.save
  end

  def test_cant_add_item_with_bad_name
    item = Item.new(:title => "Title", :name => "this is a test", :user => users(:quentin))
    assert !item.save
  end

end
