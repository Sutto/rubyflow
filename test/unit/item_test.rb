require File.dirname(__FILE__) + '/../test_helper'

class ItemTest < ActiveSupport::TestCase
  should_belong_to :user
  should_have_many :comments
  should_have_many :stars
  
  should_ensure_length_in_range :title, (4..255)
  should_ensure_length_in_range :name, (4..255)
  should_ensure_length_in_range :content, (25..1200)
  
  # TODO test tagging stuff
  
  context 'An Item' do
    setup do
      @item = Factory(:item, :name => 'ihasname')
    end
    
    should_require_unique_attributes :name
    
    should_allow_values_for :name, 'name-1', 'name_1'
    should_not_allow_values_for :name, 'name 1'
    
    should_allow_values_for :tags, ':foo :bar'
    
    should 'use name for #to_param' do
      assert_equal @item.name, @item.to_param
    end
    
    context 'that has been starred by a user' do
      setup do
        @user = Factory(:user)
        @user.stars.create(:item => @item)
      end
      
      should 'be starred by user' do
        assert @item.is_starred_by_user(@user)
      end
      
      should 'generate starred css class' do
        assert_equal 'starred', @item.starred_class(@user)
      end
    end
    
    context 'that has not been starred by a user' do
      setup do
        @user = Factory(:user)
      end
      
      should 'be starred by user' do
        assert !@item.is_starred_by_user(@user)
      end
      
      should 'generate empty css class' do
        assert_equal '', @item.starred_class(@user)
      end
    end
  end
  
  context 'An Item without a name' do
    setup do
      @item = Factory(:item, :name => nil)
    end
    
    should 'use id for #to_param' do
      assert_equal @item.id, @item.to_param
    end
  end
  
  # context 
  
  fixtures :users

  # FIXME fails to save
  # def test_can_add_item_with_no_name
  #   item = Item.new(:title => "Title", :user => users(:quentin))
  #   assert item.save
  # end

  def test_cant_add_item_with_bad_name
    item = Item.new(:title => "Title", :name => "this is a test", :user => users(:quentin))
    assert !item.save
  end

end