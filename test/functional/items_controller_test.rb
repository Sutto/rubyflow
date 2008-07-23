require File.dirname(__FILE__) + '/../test_helper'

class ItemsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:items)
  end

  def test_shouldnt_get_new
    get :new
    assert_response :redirect
  end

  def test_shouldnt_create_item
    assert_no_difference('Item.count') do
      post :create, :item => { }
    end
  end

  def test_should_show_item
    get :show, :id => items(:one).id
    assert_response :success
  end

  def test_shouldnt_get_edit
    get :edit, :id => items(:one).id
    assert_response :redirect
  end

  def test_shouldnt_update_item
    put :update, :id => items(:one).id, :item => { }
    assert_response :redirect
  end

  def test_shouldnt_destroy_item
    assert_no_difference('Item.count') do
      delete :destroy, :id => items(:one).id
    end
  end
end
