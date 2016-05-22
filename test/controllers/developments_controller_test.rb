require 'test_helper'

class DevelopmentsControllerTest < ActionController::TestCase
  setup do
    @development = developments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:developments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create development" do
    assert_difference('Development.count') do
      post :create, development: { address: @development.address, delivery_month: @development.delivery_month, delivery_year: @development.delivery_year, description: @development.description, development_type: @development.development_type, info: @development.info, lat: @development.lat, lng: @development.lng, title: @development.title, slug: @development.slug, stage: @development.stage, status: @development.status, zip_code: @development.zip_code, zone_id: @development.zone_id }
    end

    assert_redirected_to development_path(assigns(:development))
  end

  test "should show development" do
    get :show, id: @development
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @development
    assert_response :success
  end

  test "should update development" do
    patch :update, id: @development, development: { address: @development.address, delivery_month: @development.delivery_month, delivery_year: @development.delivery_year, description: @development.description, development_type: @development.development_type, info: @development.info, lat: @development.lat, lng: @development.lng, title: @development.title, slug: @development.slug, stage: @development.stage, status: @development.status, zip_code: @development.zip_code, zone_id: @development.zone_id }
    assert_redirected_to development_path(assigns(:development))
  end

  test "should destroy development" do
    assert_difference('Development.count', -1) do
      delete :destroy, id: @development
    end

    assert_redirected_to developments_path
  end
end
