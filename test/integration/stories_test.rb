require File.dirname(__FILE__) + '/../test_helper'

class StoriesTest < ActionController::IntegrationTest
  fixtures :all

  def test_404
    get "/items/nosuchitem"
    assert_response :missing
  end
  
  def test_no_login_and_no_edit
    get "/items/MyString1"
    assert_response :success
  end
  
  def test_failed_edit_then_login_and_edit
    get "/items/edit/MyString1"
    assert_response :redirect
    post "/session", :login => 'quentin', :password => 'test'
    assert_response :redirect
    get "/items/edit/MyString1"
    assert_response :success
  end
  
  def test_non_admin_login_to_test_edit
    post "/session", :login => 'quentin', :password => 'test'
    assert_response :redirect
    get "/items/edit/MyString1"
    assert_response :success    
  end
end