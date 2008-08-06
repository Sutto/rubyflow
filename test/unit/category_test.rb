require File.dirname(__FILE__) + '/../test_helper'

class CategoryTest < ActiveSupport::TestCase
  
  should_require_attributes :title, :parent_id
  should_ensure_length_in_range :title, (4..255)
  should_require_unique_attributes :name
  should_ensure_length_in_range :name, (4..255)
  # TODO test validates_format_of values

  context 'Category with a short name' do
    setup do
      @category = Category.create(:name => 'yuk')
    end
    
    should 'use id for #to_param' do
      assert_equal @category.id, @category.to_param
    end
  end
  
  context 'Category with long name' do
    setup do
      @category = Category.create(:name => 'ever-so-slightly-longer')
    end
    
    should 'use name for #to_param' do
      assert_equal @category.name, @category.to_param
    end
  end
  
  # TODO contexts for Category with short/long title to test publicly_facing_name
end
