require 'test_helper'

class ShowcaseItemsControllerTest < ActionController::TestCase
  setup do
    @showcase_item = showcase_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:showcase_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create showcase_item" do
    assert_difference('ShowcaseItem.count') do
      post :create, showcase_item: { showcaseable_id: @showcase_item.showcaseable_id, showcaseable_type: @showcase_item.showcaseable_type }
    end

    assert_redirected_to showcase_item_path(assigns(:showcase_item))
  end

  test "should show showcase_item" do
    get :show, id: @showcase_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @showcase_item
    assert_response :success
  end

  test "should update showcase_item" do
    patch :update, id: @showcase_item, showcase_item: { showcaseable_id: @showcase_item.showcaseable_id, showcaseable_type: @showcase_item.showcaseable_type }
    assert_redirected_to showcase_item_path(assigns(:showcase_item))
  end

  test "should destroy showcase_item" do
    assert_difference('ShowcaseItem.count', -1) do
      delete :destroy, id: @showcase_item
    end

    assert_redirected_to showcase_items_path
  end
end
