require 'test_helper'

class SiteHoursControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:site_hours)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create site_hour" do
    assert_difference('SiteHour.count') do
      post :create, :site_hour => { }
    end

    assert_redirected_to site_hour_path(assigns(:site_hour))
  end

  test "should show site_hour" do
    get :show, :id => site_hours(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => site_hours(:one).to_param
    assert_response :success
  end

  test "should update site_hour" do
    put :update, :id => site_hours(:one).to_param, :site_hour => { }
    assert_redirected_to site_hour_path(assigns(:site_hour))
  end

  test "should destroy site_hour" do
    assert_difference('SiteHour.count', -1) do
      delete :destroy, :id => site_hours(:one).to_param
    end

    assert_redirected_to site_hours_path
  end
end
