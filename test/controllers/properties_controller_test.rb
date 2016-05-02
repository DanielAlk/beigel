require 'test_helper'

class PropertiesControllerTest < ActionController::TestCase
  setup do
    @property = properties(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:properties)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create property" do
    assert_difference('Property.count') do
      post :create, property: { address: @property.address, age: @property.age, area_unit: @property.area_unit, bathrooms: @property.bathrooms, constructed_area: @property.constructed_area, description: @property.description, environments: @property.environments, garages: @property.garages, lat: @property.lat, lng: @property.lng, property_type_id: @property.property_type_id, rent_currency: @property.rent_currency, rent_price: @property.rent_price, sale_currency: @property.sale_currency, sale_price: @property.sale_price, slug: @property.slug, title: @property.title, toilettes: @property.toilettes, unconstructed_area: @property.unconstructed_area, zip_code: @property.zip_code, zone_id: @property.zone_id }
    end

    assert_redirected_to property_path(assigns(:property))
  end

  test "should show property" do
    get :show, id: @property
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @property
    assert_response :success
  end

  test "should update property" do
    patch :update, id: @property, property: { address: @property.address, age: @property.age, area_unit: @property.area_unit, bathrooms: @property.bathrooms, constructed_area: @property.constructed_area, description: @property.description, environments: @property.environments, garages: @property.garages, lat: @property.lat, lng: @property.lng, property_type_id: @property.property_type_id, rent_currency: @property.rent_currency, rent_price: @property.rent_price, sale_currency: @property.sale_currency, sale_price: @property.sale_price, slug: @property.slug, title: @property.title, toilettes: @property.toilettes, unconstructed_area: @property.unconstructed_area, zip_code: @property.zip_code, zone_id: @property.zone_id }
    assert_redirected_to property_path(assigns(:property))
  end

  test "should destroy property" do
    assert_difference('Property.count', -1) do
      delete :destroy, id: @property
    end

    assert_redirected_to properties_path
  end
end
